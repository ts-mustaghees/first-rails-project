class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @feed = current_user.feed.includes([:comments, :user]).paginate(page: params[:page], per_page: 12)
      @post = current_user.posts.build
    end
  end

  def timer
  end
end
