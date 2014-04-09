class Comment < ActiveRecord::Base

  belongs_to :author, :class_name =>:user, :foreign_key =>'author_id'
  belongs_to :post

  validates :content, :presence => true

  def status
    if self.published
      return 'Published'
    elsif self.pending
      return 'Programmed'
    elsif self.deleted
      return 'Deleted'
    else
      return 'Draft'
    end
  end

end
