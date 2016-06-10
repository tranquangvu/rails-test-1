class VoteHandler
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :joke_id, :user_id

  def initialize(joke_id, user_id)
    @joke_id = joke_id
    @user_id = user_id
  end

  def joke
    @joke = Joke.find(joke_id)
  end

  def like
    joke.votes.create(vote_type: 'like', user_id: user_id)
  end

  def dislike
    joke.votes.create(vote_type: 'dislike', user_id: user_id)
  end

  def next_joke
    Joke.next_joke(user_id)
  end

  def persisted?
    false
  end
end
