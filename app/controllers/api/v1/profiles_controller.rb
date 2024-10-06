module Api
  module V1
    class ProfilesController < ApplicationController
      before_action :authenticate_user!

      # GET /api/v1/profiles
      def show
        render json: current_user.as_json(only: [ :name, :surname, :email, :profession, :city, :country, :profile_image_url, :banner_image_metadata, :address, :phone_number, :bio ]), status: :ok
      end

      # PUT /api/v1/profiles
      def update
        if current_user.update(profile_params)
          render json: { message: "Profile updated successfully", user: current_user.as_json(only: [ :name, :surname, :email, :profession, :city, :country, :profile_image_url, :banner_image_metadata, :address, :phone_number, :bio ]) }, status: :ok
        else
          render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def profile_params
        params.require(:user).permit(:name, :surname, :email, :profession, :city, :country, :profile_image_url, :banner_image_metadata, :address, :phone_number, :bio)
      end
    end
  end
end
