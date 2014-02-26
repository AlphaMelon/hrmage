# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization_holiday do
    name "Random Holiday"
    date Date.today.to_s
  end
end
