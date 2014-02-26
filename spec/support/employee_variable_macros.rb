module EmployeeVariableMacros

  def create_employee_variable
    @employee_variable_attr = FactoryGirl.attributes_for(:employee_variable)
    @employee_variable = EmployeeVariable.new(@employee_variable_attr)
    @employee_variable.employee = Employee.first
    @employee_variable.leave_type = LeaveType.first
    @employee_variable.save
        
  end

  
end
