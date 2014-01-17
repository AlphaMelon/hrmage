# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization_setting do
    monday 8
    tuesday 8
    wednesday 8
    thursday 8
    friday 8
    saturday 4
    minimum_leave 1
  end
end
