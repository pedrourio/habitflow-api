# app/controllers/api/v1/habits_controller.rb

class Api::V1::HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: [:show, :update, :destroy]

  # GET /api/v1/habits
  def index
    @habits = current_user.habits.includes(:checkins).order(created_at: :desc)
    render json: @habits
  end

  # GET /api/v1/habits/:id
  def show
    render json: @habit
  end

  # POST /api/v1/habits
  def create
    @habit = current_user.habits.build(habit_params)

    if @habit.save
      render json: @habit, status: :created
    else
      render json: { errors: @habit.errors.full_messages }, status: :unprocessable_entity
    end
  end



  # PATCH/PUT /api/v1/habits/:id
  def update
    if @habit.update(habit_params)
      # Usamos o serializer para garantir que os check-ins sejam incluídos na resposta
      render json: HabitSerializer.new(@habit).to_h_with_checkins.first
    else
      render json: { errors: @habit.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/habits/:id
  def destroy
    @habit.destroy
    head :no_content
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:name, :description)
  end
end