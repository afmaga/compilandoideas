class AddLaterPostToPost < ActiveRecord::Migration
  def change
    add_column :posts, :later_post_id, :integer

    add_column :posts, :previous_post_id, :integer

  end
end
