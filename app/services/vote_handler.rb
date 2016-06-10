class VoteHandler
  attr_reader :joke, :user

  def initialize(joke, user)
    @joke = joke
    @user = user
  end

  def like
    joke.votes.create(vote_type: 'like', user_id: user.id)
  end

  def dislike
    joke.votes.create(vote_type: 'dislike', user_id: user.id)
  end

  def next_joke
    user.next_joke
  end
end
