module LeaveMacros

  def create_leave
    @leave_attr = FactoryGirl.attributes_for(:leave)
    @leave = Leave.new(@leave_attr)
    @leave.organization = Organization.first
    @leave.employee = Employee.first
    @leave.leave_type = LeaveType.first
    @leave.save
  end

  
end
