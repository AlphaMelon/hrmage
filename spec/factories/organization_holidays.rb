# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization_holiday do
    name "MyString"
    date "2014-01-17"
    organization_setting_id 1
    organization_id ""
  end
end
