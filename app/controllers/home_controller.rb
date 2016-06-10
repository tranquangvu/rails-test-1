class HomeController < ApplicationController
	before_action :authenticate_user!

	def index
		@joke = Joke.next_joke(current_user.id)
	end
end
