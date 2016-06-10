class Joke < ActiveRecord::Base
	has_many :votes, dependent: :destroy

	validates :content, presence: true, length: { minimum: 20 }
end
