class CreateCheckins < ActiveRecord::Migration[8.0]
  def change
    create_table :checkins do |t|
      t.date :date
      t.references :habit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
