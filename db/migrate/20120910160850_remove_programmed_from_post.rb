class RemoveProgrammedFromPost < ActiveRecord::Migration
  def up
    remove_column :comments, :programmed
    add_column :comments, :pending, :boolean
  end

  def down
    add_column :comments, :programmed, :boolean
    remove_column :comments, :pending
  end
end
