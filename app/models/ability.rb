class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    @user ? user_rules : guest_rules
  end

  def user_rules
    @user.roles.each { |role| send("#{role}_rules") }
    default_rules
  end

  # admin role
  def admin_rules
    can :manage, :all
  end

  def guest_rules
  end

  def default_rules
    can :read, :all
  end
end
