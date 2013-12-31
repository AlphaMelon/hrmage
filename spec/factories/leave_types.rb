# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :leave_type do
    name "Annual leave"
    approval_needed true
    description "yearly leaves"
    affected_entity ["count", "salary"]
    type "LeaveSubstraction"
    organization_id 1
  end
end
