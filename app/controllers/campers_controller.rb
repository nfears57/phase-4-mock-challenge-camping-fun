class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessible_entity_response

    def index
        camper = Camper.all
        render json: camper
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CampersWithActivitiesSerializer
    
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: {error: "Scientist not found"}, status: :not_found
    end

    def render_unprocessible_entity_response
        render json: {errors: exception.record.errors.full_messages }, status: :unprocessible_entity
    end
end
