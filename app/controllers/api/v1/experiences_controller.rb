module Api
    module V1
      class ExperiencesController < ApplicationController
        before_action :authenticate_api_v1_user!
        before_action :set_experience, only: [:show, :update, :destroy]
  
        # GET /api/v1/experiences
        def index
          @experiences = current_api_v1_user.experiences
          render json: @experiences
        end
  
        # POST /api/v1/experiences
        def create
          @experience = current_api_v1_user.experiences.build(experience_params)
          if @experience.save
            render json: @experience, status: :created
          else
            render json: @experience.errors, status: :unprocessable_entity
          end
        end
  
        # GET /api/v1/experiences/:id
        def show
          render json: @experience
        end
  
        # PATCH/PUT /api/v1/experiences/:id
        def update
          if @experience.update(experience_params)
            render json: @experience
          else
            render json: @experience.errors, status: :unprocessable_entity
          end
        end
  
        # DELETE /api/v1/experiences/:id
        def destroy
          @experience.destroy
          head :no_content
        end
  
        private
  
        def set_experience
          @experience = current_api_v1_user.experiences.find(params[:id])
        end
  
        def experience_params
          params.require(:experience).permit(:title, :company_name, :location, :start_date, :end_date, :current, :description)
        end
      end
    end
  end
  