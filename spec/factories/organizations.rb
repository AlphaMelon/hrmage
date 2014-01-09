# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    #sequence(:name, 1000) { |n| "organization#{n}" }
    #sequence(:domain, 1000) { |n| "domain#{n}" }
    name "AlphaMelon"
    domain "alphamelontest.hrmage.dev"
    default_currency "myr"
  end
end
