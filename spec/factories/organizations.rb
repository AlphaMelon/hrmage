# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    #sequence(:name, 1000) { |n| "organization#{n}" }
    #sequence(:domain, 1000) { |n| "domain#{n}" }
    name "AlphaMelonTesting"
    country "Malaysia"
    default_currency "myr"
    time_zone "Kuala Lumpur"
  end
end
