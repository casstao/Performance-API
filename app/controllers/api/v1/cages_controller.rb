module Api
  module V1
    class CagesController < ApplicationController
      def index
        #general get HTTP call
        cages = Cage.order('status DESC');
        render json: {status: 'SUCCESS', message:'Loaded Cages', data:cages}, status: :ok
      end

      def show
        #shows cage with id or status parameter
        if numeric(params[:id])
          if not Cage.exists?(params[:id])
            render json: {status: 'ERROR',
            message:'Cage ID does not exist'},
            status: :unprocessable_entity
            return
          else
            cage = Cage.find(params[:id])
            render json: {status: 'SUCCESS', message:'Loaded Cage ' + params[:id], data:cage.dinos},
            status: :ok
            return
          end
        else
          cage = Cage.where(status: params[:id])
          render json: {status: 'SUCCESS', message:'Loaded cages of status ' + params[:id].to_s, data:cage}, status: :ok
          return
        end
      end

      def create
        #creates new cage
          cage = Cage.new(cage_params)
          #determines if cage_parameters are valid
          if not cage_params.include?("max_capacity")
            render json: {status: 'ERROR', message:'Cage entry must have max_capacity variable'},
            status: :unprocessable_entity
            return
          elsif not cage_params.include?("status")
            render json: {status: 'ERROR', message:'Cage entry must have status variable'},
            status: :unprocessable_entity
            return
          elsif cage.max_capacity < 0 || (cage.status != "DOWN" && cage.status != "ACTIVE")
            render json: {status: 'ERROR', message:'Cage inputs incorrect'}, status: :unprocessable_entity
            return
          end
          cage.update_attribute("current_capacity", 0)
          cage.update_attribute("cage_type", "None")
          if cage.save
            render json: {status: 'SUCCESS', message:'saved cage', data:cage}, status: :ok
            return
          else
            render json: {status: 'ERROR', message:'Cage not saved',
            data:cage.errors}, status: :unprocessable_entity
          end
      end

      def destroy
          #delete a cage
          cageID = params[:id]
          if not Cage.exists?(cageID)
            render json: {status: 'ERROR', message:'Cage not found',},
             status: :unprocessable_entity
            return
          end
          cage = Cage.find(cageID)
          cage.destroy
          render json: {status: 'SUCCESS', message:'deleted cage '+ params[:id], data:cage}, status: :ok
      end

      def update
        cage = Cage.find(params[:id])
        if params[:status] == "DOWN" and cage.dinos.count != 0
          render json: {status: 'ERROR', message:'Cage cannot be powered down with dinos in it'},
          status: :unprocessable_entity
          return
        elsif cage.update_attributes(cage_params)
          render json: {status: 'SUCCESS', message:'updated cage ' + params[:id], data:cage}, status: :ok
          return
        else
          render json: {status: 'ERROR', message:'Cage not updated',
          data:cage.errors}, status: :unprocessable_entity
        end
      end

      private
      def cage_params
        params.permit(:max_capacity, :status, :cage_type)

      end

      #determines if input is numerical string
      def numeric(input)
        return Float(input) != nil rescue false
      end
    end

  end
end
