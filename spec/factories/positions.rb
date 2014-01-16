# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position do
    name "Executive"
    max_leaves_seconds 1209600
    max_claims_cents 560000
    can_approve_leave true
    can_approve_claim true
  end
end
