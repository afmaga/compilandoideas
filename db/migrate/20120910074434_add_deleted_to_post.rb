class AddDeletedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :deleted, :boolean

  end
end
