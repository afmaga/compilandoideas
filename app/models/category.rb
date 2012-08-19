class Category < ActiveRecord::Base
  has_many :posts
  has_one :parent_category, :class_name => 'Category' , :foreign_key => 'parent_category_id'

  def sub_cats
    
  end
end
