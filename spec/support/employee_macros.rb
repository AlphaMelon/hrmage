module EmployeeMacros

  def create_employee
    organization = Organization.first
  
    account = Account.first
    account_organization = AccountOrganization.new(account_id: account.id, organization_id: organization.id, role: "Admin")
    account_organization.save
    
    position = Position.first
    
    employee_attr = FactoryGirl.attributes_for(:employee)
    employee = Employee.create!(employee_attr)
    employee.account_id = account.id
    employee.organization_id = organization.id
    employee.position_id = position.id
    employee.save
    
    department = Department.first
    employee_department = EmployeeDepartment.new(employee_id: employee.id, department_id: department.id, leader: true)
    employee_department.save
  end

  def create_employee_cancan(can_approve_leave, can_approve_claim)
    organization = Organization.first
  
    account = Account.new
    account.email = "testing@example.dev"
    account.password = "spree123"
    account.save
    
    account_organization = AccountOrganization.new(account_id: account.id, organization_id: organization.id, role: "Employee")
    account_organization.save
    
    position = Position.new(name: "Clerk", max_leaves_seconds: 14, max_claims_cents: 240000, can_approve_leave: can_approve_leave, can_approve_claim: can_approve_claim)
    position.save
  
    employee = Employee.new(first_name: "Test", last_name: "lee", available_leaves_seconds: 10, available_claims_cents: 150000, can_self_approve: true)
    employee.account_id = account.id
    employee.organization_id = organization.id
    employee.position_id = position.id
    employee.save
    
    department = Department.first
    employee_department = EmployeeDepartment.new(employee_id: employee.id, department_id: department.id, leader: true)
    employee_department.save
  end
end
