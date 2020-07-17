class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed = current_user.feed(params[:page])
      @post = current_user.posts.build
    end
  end

  def timer
  end
end
