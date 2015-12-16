class UpdateUserColumns < ActiveRecord::Migration
  def change
    remove_column :users, :email
    add_column :users, :email, :string
    add_index :users, :email, unique: true
  end
end
