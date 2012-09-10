class AddDraftToComment < ActiveRecord::Migration
  def change
    add_column :comments, :draft, :boolean

  end
end
