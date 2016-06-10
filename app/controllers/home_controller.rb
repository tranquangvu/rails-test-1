class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @joke = current_user.next_joke
  end
end
