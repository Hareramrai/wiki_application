class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.author?
      can :manage,  Article do |article|
        article.user_id.nil? or article.user_id == user.id
      end 
      can :show, Article  
    else
      can :read, :all
    end
  end
end
