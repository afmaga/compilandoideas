class AddProgrammedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :programmed, :boolean

  end
end
