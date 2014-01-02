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

  
end
