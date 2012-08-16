class Post < ActiveRecord::Base

  belongs_to :category, :foreign_key => 'category_id'
  belongs_to :author, :class =>:user, :foreign_key =>'author_id'

  def self.previous
      posts = Post.find('all', :condition =>array(:status =>'published', :order_by =>'created_at ASC'))
      posts.each do |p|
        if strftime(p.created_at) >= strtotime(self.created_at)
          return p
        end
      end
  end

  def self.later
    posts = Post.find('all', :condition =>array(:status =>'published', :order_by =>'created_at ASC'))
    posts.each do |p|
        if strftime(p.created_at) <= strtotime(self.created_at)
          return p
        end
      end
  end
  
end
