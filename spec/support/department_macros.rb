module DepartmentMacros

  def create_department
    @department_attr = FactoryGirl.attributes_for(:department)
    @document = Department.create!(@department_attr)
  end

  
end
