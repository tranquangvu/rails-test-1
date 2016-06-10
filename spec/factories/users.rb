FactoryGirl.define do
  factory :user do
    sequence(:email)    { |n| "test#{n}@gmail.com" }
    password            'qwertyuiop'
  end       
end
