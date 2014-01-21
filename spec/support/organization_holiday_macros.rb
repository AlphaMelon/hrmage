module OrganizationHolidayMacros

  def create_organization_holiday
    @organization_holiday_attr = FactoryGirl.attributes_for(:organization_holiday)
    @organization_holiday = OrganizationHoliday.create!(@organization_holiday_attr)
    @organization_holiday.organization = Organization.first
    @organization_holiday.organization_setting = OrganizationSetting.first
    @organization_holiday.save
  end
    
end
