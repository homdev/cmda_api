module Api
  module V1
    class PasswordsController < Devise::PasswordsController
      respond_to :json

      # POST /api/v1/users/password
      def create
        user = User.find_by_email(password_params[:email])
        if user
          user.send_reset_password_instructions
          render json: { message: "Password reset instructions sent" }, status: :ok
        else
          render json: { error: "Email not found" }, status: :not_found
        end
      end

      # PUT /api/v1/users/password
      def update
        user = User.reset_password_by_token(reset_password_params)
        if user.errors.empty?
          render json: { message: "Password updated successfully" }, status: :ok
        else
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def password_params
        params.require(:user).permit(:email)
      end

      def reset_password_params
        params.require(:user).permit(:reset_password_token, :password, :password_confirmation)
      end
    end
  end
end
