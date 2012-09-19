class Company < ActiveRecord::Base
  attr_accessible :about, :address, :contract, :culture, :fax, :links, :mobile, :name, :qq, :tel, :email

  attr_accessor :file

  has_many :attachments, :as => :attachmentable

  # validation
  validates_presence_of :name, :contract, :fax, :mobile, :qq, :tel, :email, :about, :culture
  validate :validation_of_add_company, :on => :create
  def validation_of_add_company
    if Company.all.size > 0
      errors[:name] << "The quantity of companies must one"
    end
  end
  private :validation_of_add_company
end
