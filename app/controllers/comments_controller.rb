class CommentsController < ApplicationController
  require "posts_api"
  before_action :set_api_data, only: [:create]

  def create
    @comment = @posts_api.save_comment(params)
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.prepend(:comments, partial: "comments/comment", locals: { comment: @comment })
      end
    end
  end
  
  private
  
  def set_api_data
    # comments = @posts_api.comments(params[:comment][:post_id])
    @posts_api = PostsAPI.new
  end

  def comment_params
    params.require(:comment).permit(:name, :body, :post_id)
  end
end