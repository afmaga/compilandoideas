class AddProgrammedToComment < ActiveRecord::Migration
  def change
    add_column :comments, :programmed, :boolean

  end
end
