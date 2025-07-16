# app/controllers/api/v1/checkins_controller.rb

class Api::V1::CheckinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit

  # GET /api/v1/habits/:habit_id/checkins
  def index
    @checkins = @habit.checkins.order(date: :desc)
    render json: @checkins
  end

  # POST /api/v1/habits/:habit_id/checkins
  def create
    # Garante que não haja check-in duplicado para o mesmo dia
    @checkin = @habit.checkins.find_or_initialize_by(date: checkin_params[:date])

    if @checkin.new_record? && @checkin.save
      render json: @checkin, status: :created
    else
      # Se o check-in já existe ou falhou ao salvar
      render json: { errors: @checkin.errors.full_messages.presence || ["Check-in for this date already exists."] }, 
             status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/habits/:habit_id/checkins/:id
  def destroy
    @checkin = @habit.checkins.find(params[:id])
    @checkin.destroy
    head :no_content
  end

  private

  def set_habit
    # IMPORTANTE: Garante que o usuário só pode acessar hábitos que pertencem a ele
    @habit = current_user.habits.find(params[:habit_id])
  end

  def checkin_params
    params.require(:checkin).permit(:date)
  end
end