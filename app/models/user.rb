#encoding:utf-8
class User < ActiveRecord::Base
  # constant
  ROLES = %w[admin]
  LOGINABLE_TYPES = { false => '禁止', true => '允许' }

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :loginable
  # attr_accessible :title, :body

  ####################
  # instance methods #
  ####################
  def active_for_authentication?
    # Comment out the below debug statement to view the properties of the returned self model values.
    # logger.debug self.to_yaml
    super && loginable?
  end

  def roles=(roles)
    self.roles_mask = ( [ roles ].flatten & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def any_roles?(*a)
    !(roles & a.map{|i| i.to_s}).empty?
  end

  def checkable?(program)
    programs.include? program
  end

  def priority
    if id == 1
      0
    elsif is?(:admin)
      -1
    else
      -100
    end
  end

  private
  def email_required?
    false
  end

  def password_required?
    self.loginable? && new_record? || password.present?
  end
end
