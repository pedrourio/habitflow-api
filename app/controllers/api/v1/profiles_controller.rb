
class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_user!

  # GET /api/v1/profile
  def show
    render json: UserSerializer.new(current_user).to_h
  end

  # PUT /api/v1/profile
  def update
    if current_user.update(profile_params)
      render json: UserSerializer.new(current_user).to_h
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    # Por enquanto, só permitimos a atualização do nome
    params.require(:user).permit(:name)
  end
end