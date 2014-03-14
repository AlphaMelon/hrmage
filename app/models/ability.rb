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
      can :read, Organization
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
      
      can :read, ClaimSubject if acc_org.claim_subject[0..3] == "Read"
      can :create, ClaimSubject if acc_org.claim_subject == "Read and Create"
      can :update, ClaimSubject if acc_org.claim_subject == "Read and Update"
      can :manage, ClaimSubject if acc_org.claim_subject == "Manage all"

      can :read, Department if acc_org.department[0..3] == "Read"
      can :create, Department if acc_org.department == "Read and Create"
      can :update, Department if acc_org.department == "Read and Update"
      can :manage, Department if acc_org.department == "Manage all"
      
      can :read, Employee if acc_org.employee[0..3] == "Read"
      can :create, Employee if acc_org.employee == "Read and Create"
      can :update, Employee if acc_org.employee == "Read and Update"
      can :manage, Employee if acc_org.employee == "Manage all"

      can :read, LeaveType if acc_org.leave_type[0..3] == "Read"
      can :create, LeaveType if acc_org.leave_type == "Read and Create"
      can :update, LeaveType if acc_org.leave_type == "Read and Update"
      can :manage, LeaveType if acc_org.leave_type == "Manage all"

      can :read, Payslip if acc_org.payslip[0..3] == "Read"
      can :create, Payslip if acc_org.payslip == "Read and Create"
      can :update, Payslip if acc_org.payslip == "Read and Update"
      can :manage, Payslip if acc_org.payslip == "Manage all"

      can :read, PayslipSetting if acc_org.payslip_setting[0..3] == "Read"
      can :create, PayslipSetting if acc_org.payslip_setting == "Read and Create"
      can :update, PayslipSetting if acc_org.payslip_setting == "Read and Update"
      can :manage, PayslipSetting if acc_org.payslip_setting == "Manage all"
      
      can :read, Position if acc_org.position[0..3] == "Read"
      can :create, Position if acc_org.position == "Read and Create"
      can :update, Position if acc_org.position == "Read and Update"
      can :manage, Position if acc_org.position == "Manage all"

      can :read, PositionSetting if acc_org.position[0..3] == "Read"
      can :create, PositionSetting if acc_org.position == "Read and Create"
      can :update, PositionSetting if acc_org.position == "Read and Update"
      can :manage, PositionSetting if acc_org.position == "Manage all"

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
