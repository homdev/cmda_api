class Api::V1::UsersController < ApplicationController
    before_action :authenticate_api_v1_user!
    

    def index
      users = User.all
      render json: users
    end

    def show
      user = User.find(params[:id])
      render json: user.to_json(include: :experiences)
    end

    private

    def authorize_admin
      render json: { error: "Not Authorized" }, status: 403 unless current_user.admin?
    end
end
