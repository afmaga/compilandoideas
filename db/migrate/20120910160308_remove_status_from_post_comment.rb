class RemoveStatusFromPostComment < ActiveRecord::Migration
  def up
    remove_column :posts, :status
    remove_column :comments, :status
  end

  def down
    add_column :posts, :status, :string
    add_cloumn :comments, :status, :string
  end
end
