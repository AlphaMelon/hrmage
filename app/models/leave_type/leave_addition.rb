class LeaveAddition < LeaveType

  def self.description
    "Addition to entity"
  end

  def calculate(employee_id, leave_type_id, duration_seconds)
    leave_type = LeaveType.find(leave_type_id)
    if leave_type.affected_entity.include?("leave")
      employee_variable = EmployeeVariable.where(employee_id: employee_id, leave_type_id: leave_type_id).first
      employee_variable.available_leaves_seconds = employee_variable.available_leaves_seconds + duration_seconds
      employee_variable.save
    end
  end

end
