class LeaveSubstraction < LeaveType

  def calculate(employee,duration_seconds)
    employee.available_leaves = employee.available_leaves - duration_seconds/24/60/60
    employee.save
  end

end
