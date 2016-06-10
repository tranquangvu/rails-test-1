FactoryGirl.define do
  factory :vote do
    vote_type		'like'
    joke
    user
  end    
end
