class AddPublishedDateToComment < ActiveRecord::Migration
  def change
    add_column :comments, :published_date, :datetime

  end
end
