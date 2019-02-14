class CreateUserDescs < ActiveRecord::Migration
  def change
    create_table :user_descs do |t|
      t.string :lname
      t.string :fname
      t.string :sname
      t.text :address
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
