class AuthController < ApplicationController
    def create
        hmac_secret = "secret"
        payload = {name: params[:name], exp: Time.now.to_i+300 }
        token = JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256'
        render json: {token: token}
    end   
end
