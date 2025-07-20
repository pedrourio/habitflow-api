
class HabitSerializer
  def initialize(habit_or_habits)
    
    @habits = Array(habit_or_habits)
  end

  def to_h_with_checkins
    @habits.map do |habit|
      {
        id: habit.id,
        name: habit.name,
        description: habit.description,
        user_id: habit.user_id,
        created_at: habit.created_at.iso8601, 
        updated_at: habit.updated_at.iso8601, 
        checkins: habit.checkins.map do |checkin|
          { id: checkin.id, date: checkin.date.iso8601 }
        end
      }
    end
  end
end