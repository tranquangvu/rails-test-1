class Vote < ActiveRecord::Base
  belongs_to :joke
  belongs_to :user

  validates :vote_type, presence: true
end
