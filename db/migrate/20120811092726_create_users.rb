class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :hashed_password
      t.string :salt
      t.string :name
      t.string :f_name
      t.string :l_name
      t.boolean :active
      t.string :role

      t.timestamps
    end
  end
end
