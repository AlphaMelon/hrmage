# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :claim do
    subject "Petrol"
    date Date.today
    amount_cents 7781
    comment "Gone to Tropicana"
    status "Pending"
  end
end
