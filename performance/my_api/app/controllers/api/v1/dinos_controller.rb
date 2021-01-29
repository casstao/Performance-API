module Api
  module V1
    class DinosController < ApplicationController
      def index
        dinos = Dino.order('species DESC');
        render json: {status: 'SUCCESS', message:'Loaded dinos', data:dinos}, status: :ok
      end

      def show
        dino = Dino.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded dinos', data:dino}, status: :ok
      end

      def create
        dino = Dino.new(dino_params)
        cageID = params[:cage_id]

        #if cage does not exist
        if not Cage.exists?(cageID)
          render json: {status: 'ERROR',
          message:'Cage ' + cageID.to_s + ' not created yet - please create cage'},
          status: :unprocessable_entity
        end

        #if cage is down
        cage = Cage.find(cageID)
        if cage.status == "DOWN"
            render json: {status: 'ERROR',
            message:'Cage ' + cageID.to_s + ' is currently down - please power up cage'},
            status: :unprocessable_entity

        #Each dinosaur must have a valid species
        elsif not ['Tyrannosaurus','Velociraptor','Spinosaurus','Megalosaurus','Brachiosaurus', 'Stegosaurus','Ankylosaurus','Triceratops'].include? params[:species]
          render json: {status: 'ERROR',
          message:'Dino species does not exist'},
          status: :unprocessable_entity
        end

        add_dino_type(dino)

        #cage to dino compatibility
        if cage_max_capacity(cage)
          render json: {status: 'ERROR',
          message:'Cage at max capacity - please put dinosaur into another cage'},
          status: :unprocessable_entity

        elsif not dino_cage_compatible(dino, cage)
          render json: {status: 'ERROR',
          message:'Dino species does not match cage species'},
          status: :unprocessable_entity

        elsif dino.save
          cage.update_attribute("current_capacity", cage.current_capacity + 1)
          render json: {status: 'SUCCESS', message:'Saved Dino', data:dino}, status: :ok
        else
          render json: {status: 'ERROR', message:'Dino not saved',
          data:dino.errors}, status: :unprocessable_entity
        end
      end

      def destroy
          dino = Dino.find(params[:id])
          cage = dino.cage_id
          cage.update_attribute('current_capacity', cage.current_capacity - 1)
          if cage.current_capacity == 0
            cage.update_attribute('cage_type', 'None')
          dino.destroy
          render json: {status: 'SUCCESS', message:'deleted dino', data:dino}, status: :ok
      end

      def update
        dino = Dino.find(params[:id])
        if dino.update_attributes(dino_params)
          render json: {status: 'SUCCESS', message:'updated dino', data:dino}, status: :ok

        else
          render json: {status: 'ERROR', message:'dino not updated',
          data:dino.errors}, status: :unprocessable_entity
        end
      end

      private

      def dino_params
        params.permit(:name, :species, :cage_id)
      end

      def add_dino_type(dino)
          if ['Tyrannosaurus','Velociraptor','Spinosaurus','Megalosaurus'].include? params[:species]
            dino.dino_type = "Carnivore"

          elsif ['Brachiosaurus', 'Stegosaurus','Ankylosaurus','Triceratops'].include? params[:species]
            dino.dino_type = "Herbivore"
          end
          return dino
        end

      def cage_max_capacity(cage)
        if cage.max_capacity <= cage.current_capacity
          return true
        else
          return false
        end
      end

      def dino_cage_compatible(dino, cage)
        if cage.cage_type == "None"
          cage.update_attribute("cage_type", dino.dino_type)
          return true
        elsif dino.dino_type == "Herbivore" and cage.cage_type != "Carnivore"
          return true
        elsif dino.dino_type == "Carnivore" and cage.cage_type == "Carnivore" && cage.dinos.first.species == dino.species
          return true
        else
          return false
        end
      end

    end
  end
end
