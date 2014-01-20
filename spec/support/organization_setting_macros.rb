module OrganizationSettingMacros

  def create_organization_setting
    @organization_setting_attr = FactoryGirl.attributes_for(:organization_setting)
    @organization_setting = OrganizationSetting.create!(@organization_setting_attr)
    @organization_setting.organization = Organization.first
    @organization_setting.save
  end
    
end
