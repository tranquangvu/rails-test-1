class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { thumb: "64x64#" }, default_url: "/images/:style/default_avatar.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :username, presence: true, length: { minimum: 3, maximum: 16 }

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
