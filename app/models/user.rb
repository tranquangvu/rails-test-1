class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def read_jokes
  	Joke.joins(:votes).where( votes: { user_id: id } )
  end

	def available_jokes
		Joke.all - read_jokes
	end

	def next_joke
		available_jokes.first
	end
end
