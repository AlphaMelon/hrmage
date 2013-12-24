# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :leave_type do
    name "MyString"
    description "MyText"
    affected_entity ""
    type ""
    organization_id 1
  end
end
