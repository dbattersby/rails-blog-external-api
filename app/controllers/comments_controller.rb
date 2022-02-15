class CommentsController < ApplicationController
  require "posts_api"
  before_action :set_api_data, only: [:create]

  def create
    @comment = @posts_api.save_comment(params)

    respond_to do |format|
      format.turbo_stream do
        @comment["errors"].present? ? alert_errors : alert_success
      end
    end
  end
  
  private

  def alert_errors
    alerts = []

    @comment["errors"].each do |field, error|
      alerts << { type: "error", body: "Warning: #{field} #{error[0]}" }
    end

    render turbo_stream: turbo_stream.update(:alerts, partial: "layouts/alerts", locals: { alerts: alerts, errors: true })
  end

  def alert_success
    alerts = [{ type: "success", body: "Comment has been saved" }]

    # return multiple streams
    render turbo_stream: [
      turbo_stream.prepend(:comments, partial: "comments/comment", locals: { comment: @comment["comment"] }),
      turbo_stream.update(:alerts, partial: "layouts/alerts", locals: { alerts: alerts, errors: false })
    ]
  end
  
  def set_api_data
    @posts_api = PostsAPI.new
  end
end