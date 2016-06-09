class HomeController < ApplicationController
	before_action :authenticate_user!
	before_action :get_rand_joke, only: [:index]

	def index
		session[:read_jokes] ||= []
	end

	private

	def get_rand_joke
		@joke = Joke.take_excluse(session[:read_jokes])
	end
end
