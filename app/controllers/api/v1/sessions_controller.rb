# app/controllers/api/v1/sessions_controller.rb

module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json

      # POST /api/v1/users/sign_in
      def create
        user = User.find_by_email(sign_in_params[:email])
        if user&.valid_password?(sign_in_params[:password])
          render json: { message: "Login successful", user: user, token: current_token }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      # DELETE /api/v1/users/sign_out
      def destroy
        current_user&.update_column(:jti, nil) # Révoque le token JWT
        render json: { message: "Logged out successfully" }, status: :ok
      end

      private

      def current_token
        request.env["warden-jwt_auth.token"]
      end

      def sign_in_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
