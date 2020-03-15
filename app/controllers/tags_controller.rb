class TagsController < ApplicationController
  
  require 'nokogiri'
  require 'open-uri'
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate
  before_action :set_quotes_from_tag, only: [:show]
  BASE_URL ="http://quotes.toscrape.com"

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

  def search_for_quotes(tag_search, page)
    doc = Nokogiri::HTML(open(BASE_URL+'/tag/'+tag_search+'/page/'+page.to_s))
    if !(doc.css(".row").to_s.index(/No quotes found!/i)).nil?
     return false
    end
    tag = Tag.create!(name: tag_search)
    items =  doc.css ".quote"
    items.each do |item|
      q = Quote.create!(
          quote: item.css(".text").first.content,
          author: item.css(".author").first.content,
          author_about: BASE_URL + item.css("a").first['href'],
          tags: item.css(".tags .tag").map {|i| i.content},
          tag: tag
      )   
    end
    return true
  end

  private
    def set_quotes_from_tag
      @quotes = Tag.where(name: params[:tag])[0]
      if !@quotes
        if search_for_quotes(params[:tag], 1)
          @quotes = Tag.where(name: params[:tag])[0]
        elsif
          render status: :not_found
        end
      end
      
      if !@quotes
        
      end
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:name)
    end

    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        begin 
          JWT.decode token, Rails.application.secrets.secret_key_base, true, { :algorthm => 'HS256'} 
          rescue Exception => e
            render json: {error: e.message}
        end
      end
    end
end
