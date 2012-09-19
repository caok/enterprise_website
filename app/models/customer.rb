class Customer < ActiveRecord::Base
  attr_accessible :description, :name, :category_id

  attr_accessor :file

  # validation
  validates_presence_of :name, :category, :description
  validates_uniqueness_of :name

  has_one :attachment, :as => :attachmentable
  belongs_to :category

  def about
    name + "-------" + description
  end
end
