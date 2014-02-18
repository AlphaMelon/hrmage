module CountrySettingMacros

  def create_country_setting
    @country_setting_attr = FactoryGirl.attributes_for(:country_setting)
    @country_setting = CountrySetting.create!(@country_setting_attr)
  end
  
end
