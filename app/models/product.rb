class Product < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :attachments, :as => :attachmentable
  attr_accessor :file

  # validation
  validates_presence_of :name
  validates_uniqueness_of :name

  def about
    name + "-------" + description
  end
end
