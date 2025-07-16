class AddJtiToUsers < ActiveRecord::Migration[7.1] # A versão pode ser diferente
  def change
    add_column :users, :jti, :string, null: false
    add_index :users, :jti, unique: true
  end
end