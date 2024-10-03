class Api::V1::RegistrationsController < Devise::RegistrationsController
    respond_to :json

    def create
      build_resource(sign_up_params)

      if resource.save
        sign_up(resource_name, resource) if resource.active_for_authentication?
        render json: resource, status: :created
      else
        clean_up_passwords resource
        set_minimum_password_length
        render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def sign_up_params
            params.require(:user).permit(
            :name, :surname, :email, :password, :password_confirmation,
            :profession, :city, :country, :profile_image_url,
            :banner_image_metadata, :address, :phone_number
        )
    end
end
