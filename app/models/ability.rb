class Ability
  include CanCan::Ability

  def initialize(user)
  	user ||= User.new
    if user.role?("admin")
        can :manage, :all
    elsif user.role?("developer")
        can :read, Project
        can [:read, :update], Task
    end
  end
end
