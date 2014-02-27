module EmployeeMacros

  def create_employee
    organization = Organization.first
  
    account = Account.first
    account_organization = AccountOrganization.new(account_id: account.id, organization_id: organization.id, role: "Super Admin")
    account_organization.save
    
    position = Position.first
    
    employee_attr = FactoryGirl.attributes_for(:employee)
    employee = Employee.new(employee_attr)
    employee.account_id = account.id
    employee.organization_id = organization.id
    employee.position_id = position.id
    employee.save
    
    department = Department.first
    employee_department = EmployeeDepartment.new(employee_id: employee.id, department_id: department.id, leader: true)
    employee_department.save
  end

  def create_employee_cancan(email, password, can_approve_leave, can_approve_claim, department)
    organization = Organization.first
  
    account = Account.new
    account.email = email
    account.password = password
    account.save
    
    account_organization = AccountOrganization.new(account_id: account.id, organization_id: organization.id, role: "Admin")
    account_organization.save
    
    position = Position.new(name: "Clerk", monthly_max_claims_cents: 240000, can_approve_leave: can_approve_leave, can_approve_claim: can_approve_claim)
    position.save
  
    employee = Employee.new(employee_identification: "STN999", first_name: "Test", last_name: "lee", can_self_approve: true, base_salary_cents: 300000)
    employee.account_id = account.id
    employee.organization_id = organization.id
    employee.position_id = position.id
    employee.save
    
    department = Department.where(name: department).first_or_create
    employee_department = EmployeeDepartment.new(employee_id: employee.id, department_id: department.id, leader: true)
    employee_department.save
  end
end
