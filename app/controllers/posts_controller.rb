class PostsController < ApplicationController
  require "posts_api"
  before_action :validate_data, only: [:create]
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

    alerts = [{ type: "success", body: "Post created successfully." }]

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(:alerts, partial: "layouts/alerts", locals: { alerts: alerts, errors: false })
      end
    end
  end
  
  private

  def set_api_data
    @posts_api = PostsAPI.new
  end

  def validate_data
    alerts = []
    alerts << { type: "error", body: "Post title is required." } if params[:post][:title].blank?
    alerts << { type: "error", body: "Post body is required." } if params[:post][:body].blank?
    
    if alerts.any?
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(:alerts, partial: "layouts/alerts", locals: { alerts: alerts, errors: true })
        end
      end
    end
  end
end