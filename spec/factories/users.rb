# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "spree@example.com"
    password "spree123"
    role "Super Admin"
  end
end
