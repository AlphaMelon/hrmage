class LeaveSubstraction < LeaveType

  def self.description
    "Substraction to entity"
  end
  
  def calculate(employee,duration_seconds)
    #employee.available_leaves_seconds = employee.available_leaves_seconds - duration_seconds
    employee.save
  end

end
