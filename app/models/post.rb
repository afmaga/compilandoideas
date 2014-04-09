class Post < ActiveRecord::Base

  belongs_to :category, :foreign_key => 'category_id'
  belongs_to :author, :class_name =>:user, :foreign_key =>'author_id'
  belongs_to :author, :class_name => 'User', :foreign_key =>'author_id'
  has_one :previous_post, :class_name => 'Post', :foreign_key => 'previous_post_id'
  has_one :later_post, :class_name => 'Post', :foreign_key => 'later_post_id'
  has_many :comments

  def status
    if self.published
      return 'Published'
    elsif self.programmed
      return 'Programmed'
    elsif self.deleted
      return 'Deleted'
    else
      return 'Draft'
    end
  end

  def published_comments
    return self.comments.find(:condition =>array(:published => true))
  end

end
