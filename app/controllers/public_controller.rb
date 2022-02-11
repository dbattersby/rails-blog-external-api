class PublicController < ApplicationController
  require "posts_api"
  before_action :set_api_data, only: [:home]

  def home
    @posts = @posts_api.all
  end
  
  private

  def set_api_data
    @posts_api = PostsAPI.new
  end
end
