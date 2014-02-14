# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country_holiday_setting do
    country_setting_id 1
    name "MyString"
    date "2014-02-14"
  end
end
