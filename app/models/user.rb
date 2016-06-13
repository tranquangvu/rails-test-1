class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { thumb: "64x64#" }, default_url: "/images/:style/default_avatar.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :username, presence: true, length: { minimum: 3, maximum: 16 }

  ROLES = %i[admin guest]

  def roles=(roles)
    roles = [*roles].map { |r| r.to_sym }
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def has_role?(role)
    roles.include?(role)
  end

  def available_jokes
    Joke.where.not(id: Vote.where(user_id: id).select(:joke_id))
  end

  def next_joke
    available_jokes.first
  end 
end
