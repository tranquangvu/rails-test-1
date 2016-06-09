class JokesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_joke, only: [:show, :edit, :update, :destroy]

  def index
    @jokes = Joke.all
  end

  def new
    @joke = Joke.new
  end

  def create
    @joke = Joke.new(joke_params)
    if @joke.save
      redirect_to @joke, notice: 'Joke was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def show; end

  def update
    if @joke.update(joke_params)
      redirect_to @joke, notice: 'Joke was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @joke.destroy
    redirect_to jokes_path, notice: 'Joke was successfully destroyed.'
  end

  def like
    @res = vote('like')
    get_rand_joke if @res
  end

  def dislike
    @res = vote('dislike')
    get_rand_joke if @res
  end

  private

  def joke_params
    params.require(:joke).permit(:content)
  end

  def find_joke
    @joke = Joke.find(params[:id])
  end

  def get_rand_joke
    @joke = Joke.take_excluse(session[:read_jokes])
  end

  def vote(vote_type)
    session[:read_jokes].push(params[:id]) 
    vote = Joke.find(params[:id]).votes.build(vote_type: vote_type, user: current_user)
    vote.save
  end
end
