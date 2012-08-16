class Comment < ActiveRecord::Base

  belongs_to :author, :classname =>:user, :foreign_key =>'author_id'
  belongs_to :post

  validates :content, :presence => true

end
