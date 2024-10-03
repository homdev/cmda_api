class Api::V1::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin, only: [ :destroy ]

    def index
      users = User.all
      render json: users
    end

    def show
      user = User.find(params[:id])
      render json: user
    end

    private

    def authorize_admin
      render json: { error: "Not Authorized" }, status: 403 unless current_user.admin?
    end
end
