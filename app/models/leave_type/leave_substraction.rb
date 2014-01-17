class LeaveSubstraction < LeaveType

  def calculate(employee,duration_seconds)
    employee.available_leaves_seconds = employee.available_leaves_seconds - duration_seconds
    employee.save
  end

end
