class TagsController < ApplicationController
  
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate
  before_action :set_quotes_from_tag, only: [:show]

  # GET /tags
  def index
    @tags = Tag.all
    render json: @tags
  end

  # GET /tags/1
  def show
    #@quotes =  @quotes.quotes
    #@quotes = {"quotes": @quotes.as_json(except: [:created_at, :_id, :quote_ids, :created_at, :updated_at, :tag_id])}
    render json: {quotes:  @quotes.quotes} , except: [:created_at, :_id, :quote_ids, :created_at, :updated_at, :tag_id]
  end


  private
    def set_quotes_from_tag
      @quotes = Tag.where(name: params[:tag])[0]
      if !@quotes
         puts "acionar o crawler"
         render status: :not_found
      end
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:name)
    end

    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        hmac_secret = "secret"
        begin 
          JWT.decode token, hmac_secret, true, { :algorthm => 'HS256'} 
          rescue Exception => e
            render json: {error: e.message}
        end
      end
    end
end
