class PublicController < ApplicationController
  require "posts_api"
  before_action :set_api_data, only: [:home]

  def home
    data = @posts_api.all
    @posts = data["posts"]
  end

  def posts
    @post = @posts_api.show(params[:id])
  end
  
  private

  def set_api_data
    @posts_api = PostsAPI.new
  end
end
