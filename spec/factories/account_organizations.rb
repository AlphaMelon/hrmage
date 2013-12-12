# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account_organization do
    account_id 1
    organization_id 1
    role "MyString"
  end
end
