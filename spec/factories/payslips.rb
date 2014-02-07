# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payslip do
    employee_id 1
    date "2014-02-05 11:24:19"
    commission_cents 50000
    base_salary_cents 300000
  end
end
