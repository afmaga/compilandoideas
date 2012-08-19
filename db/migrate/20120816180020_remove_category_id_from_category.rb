class RemoveCategoryIdFromCategory < ActiveRecord::Migration
  def up
    remove_column :categories, :category_id
  end

  def down
    add_column :categories, :category_id, :integer
  end
end
