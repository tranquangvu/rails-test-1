class Vote < ActiveRecord::Base
  extend Enumerize

  belongs_to :joke
  belongs_to :user

  validates :vote_type, presence: true

  enumerize :vote_type, in: [:like, :dislike]
end
