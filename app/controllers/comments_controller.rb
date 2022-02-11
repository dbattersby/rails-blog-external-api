class CommentsController < ApplicationController
  require "posts_api"
  before_action :set_api_data, only: [:create]

  def create
    @comment = @posts_api.save_comment(params)
  end

  private

  def set_api_data
    @posts_api = PostsAPI.new
  end

  def comment_params
    params.require(:comment).permit(:name, :body, :post_id)
  end
end