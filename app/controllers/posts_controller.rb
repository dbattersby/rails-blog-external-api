class PostsController < ApplicationController
  require "posts_api"
  before_action :set_api_data, only: [:show, :create]

  def show
    @post = @posts_api.show(params[:id])
    @comments = @posts_api.comments(params[:id])

    render "posts/show"
  end

  def new
  end

  def create
    @post = @posts_api.save(params)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace_html("posts/show", :post => @post)
      end
    end
  end
  
  private

  def set_api_data
    @posts_api = PostsAPI.new
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end