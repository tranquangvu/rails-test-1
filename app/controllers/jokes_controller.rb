class JokesController < ApplicationController
	before_action :authenticate_user!
	before_action :find_joke, only: [:show, :edit, :update, :destroy]

	def index
	end

	def new
	end

	def create
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def find_joke
		@joke = Joke.find(params[:id])
	end
end
