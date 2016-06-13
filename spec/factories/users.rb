FactoryGirl.define do
  factory :user do
    sequence(:email)    { |n| "test#{n}@gmail.com" }
    password            'qwertyuiop'
    username						'benben'
    avatar 							Rack::Test::UploadedFile.new(Rails.root + 'spec/fixtures/spec.jpg', 'image/jpg')
    roles_mask					2

    factory :admin do
    	roles_mask				1
    end
  end       
end
