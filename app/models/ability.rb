class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    else
    	can :like, Joke
    	can :dislike, Joke
    end
  end
end
