class Joke < ActiveRecord::Base
	has_many :votes, dependent: :destroy

	validates :content, presence: true, length: { minimum: 20 }

	def self.read_jokes(user_id)
		joins(:votes).where( votes: { user_id: user_id } )
	end

	def self.read_joke_ids(user_id)
		read_jokes(user_id).collect(&:id)
	end

	def self.next_joke(user_id)
		where.not(id: read_joke_ids(user_id)).take
	end
end
