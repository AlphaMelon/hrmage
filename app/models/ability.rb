class Ability
  include CanCan::Ability

  def initialize(account, organization)
    # Define abilities for the passed in user here. For example:
    #
    account ||= Account.new # guest user (not logged in)
    organization ||= Organization.new
    employee = Employee.where(organization_id: organization.id, account_id: account.id).first
    acc_org = AccountOrganization.where(account_id: account.id, organization_id: organization.id).first
    
    if acc_org.nil?
      acc_org = AccountOrganization.new
    end
    
    if acc_org.role == "Super Admin"
      can :manage, :all
    elsif acc_org.role == "Admin"
      can :create, Leave
      can :create, Claim
      can :read, Leave
      can :read, Claim
      can :update, Leave do |leave|
        (leave.try(:employee_id) != employee.id || employee.can_self_approve) && employee.this_employee_in_my_department?(leave.employee_id)
      end
      can :update, Claim do |claim|
        (claim.try(:employee_id) != employee.id || employee.can_self_approve) && employee.this_employee_in_my_department?(claim.employee_id)
      end
    elsif acc_org.role == "Employee"
      can :create, Leave
      can :create, Claim
    else
      can :create, Organization
      can :create, Employee
    end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
