module CountryHolidaySettingMacros

  def create_country_holiday_setting
    @country_holiday_setting_attr = FactoryGirl.attributes_for(:country_holiday_setting)
    @country_holiday_setting = CountryHolidaySetting.new(@country_holiday_setting_attr)
    @country_holiday_setting.country_setting_id = CountrySetting.first.id
    @country_holiday_setting.save
  end
  
end
