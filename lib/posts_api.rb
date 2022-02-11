require 'uri'
# require 'json'
require 'faraday'

# used to get the posts from the API
class PostsAPI
  def initialize
    @api_entry = Rails.env.development? ? "http://127.0.0.1:4000/posts" : "https://roda-api.herokuapp.com/posts"
    p "Using #{ Rails.env } API at: #{@api_entry}"
  end

  # get all posts
  def all
    data = get_data @api_entry
    data["posts"]
  end

  # GET: /posts/:id
  def show id
    get_data @api_entry + "/#{id}"
  end

  # GET: /posts/:id/comments
  def comments id
    data = get_data @api_entry + "/#{id}/comments"
    data["comments"]
  end

  # POST: /posts
  def save data
    params = { "post" => { "title" => data[:post][:title], "body" => data[:post][:body] } }
    post_data @api_entry, params
  end
  
  # POST: /posts/:id/comments
  def save_comment
    params = { "comment" => { "name" => data[:comment][:name], "body" => data[:comment][:body], "post_id" => data[:comment][:post_id] } }
    post_data @api_entry + "/#{params[:id]}/comments"
  end

  def post_data api_endpoint, params
    p "Send data to: #{api_endpoint}"
    
    uri = URI.parse(api_endpoint)
    p "Parsed URI: #{uri}"

    begin
      response = Faraday.post uri do |request|
        request.headers['Content-Type'] = 'application/json'
        request.body = params.to_json
      end
    
      if response.status == 200
        p "Request status: #{response.status}"
        JSON.parse(response.body)
      else
        p "Request status: #{response.status}"
        {}
      end
    rescue => e
      p "An error occurred:"
      p e
      {}
    end
  end

  def get_data api_endpoint
    p "Getting data from: #{api_endpoint}"

    begin
      response = Faraday.get(api_endpoint)
    
      if response.status == 200
        p "Request status: #{response.status}"
        JSON.parse(response.body)
      else
        p "Request status: #{response.status}"
        {}
      end
    rescue => e
      p "An error occurred:"
      p e
      {}
    end
  end
end