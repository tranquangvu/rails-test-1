class Joke < ActiveRecord::Base
	has_many :votes, dependent: :destroy

	validates :content, presence: true, length: { minimum: 20 }

	def self.take_excluse(jokes_id)
		where.not(id: jokes_id).take
	end
end
