module LeaveTypeMacros

  def create_leave_type
    @leave_type_attr = FactoryGirl.attributes_for(:leave_type)
    @leave_type = LeaveType.create!(@leave_type_attr)
    @leave_type.organization_id = Organization.first.id
    @leave_type.save
  end

  
end
