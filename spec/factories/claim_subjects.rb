# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :claim_subject, :class => 'ClaimSubject' do
    name "Petrol"
  end
end
