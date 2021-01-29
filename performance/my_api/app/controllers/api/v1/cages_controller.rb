module Api
  module V1
    class CagesController < ApplicationController
      def index
        cages = Cage.order('status DESC');
        render json: {status: 'SUCCESS', message:'Loaded Cages', data:cages}, status: :ok
      end

      def show
        cage = Cage.find(params[:id])
        puts "WHATS IN CAGE"
        render json: {status: 'SUCCESS', message:'Loaded Cage ' + params[:id], data:cage.dinos}, status: :ok
      end

      def create
          cage = Cage.new(cage_params)
          cage.current_capacity = 0

          if cage.save
            render json: {status: 'SUCCESS', message:'saved cage', data:cage}, status: :ok
          else
            render json: {status: 'ERROR', message:'Cage not saved',
            data:cage.errors}, status: :unprocessable_entity
          end
      end

      def destroy
          cage = Cage.find(params[:id])
          cage.destroy
          render json: {status: 'SUCCESS', message:'deleted cage '+ params[:id], data:cage}, status: :ok
      end

      def update
        cage = Cage.find(params[:id])
        if params[:status] == "DOWN" and cage.dinos.count != 0
          render json: {status: 'ERROR', message:'Cage cannot be powered down with dinos in it'}, status: :unprocessable_entity


        elsif cage.update_attributes(cage_params)
          render json: {status: 'SUCCESS', message:'updated cage ' + params[:id], data:cage}, status: :ok

        else
          render json: {status: 'ERROR', message:'Cage not updated',
          data:cage.errors}, status: :unprocessable_entity
        end
      end
      private
      def cage_params
        params.permit(:max_capacity, :current_capacity, :status, :cage_type)

      end
    end

  end
end
