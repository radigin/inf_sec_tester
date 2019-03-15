class AddHobbiesToUser < ActiveRecord::Migration
  def change
    add_column :users, :hobbies, :string
  end
end
