class Api::V1::BaseController < ApplicationController
  # We are not going to use the CSRF security token for API requests as those
  # use the google_token to verify authenticity instead.
  skip_before_filter :verify_authenticity_token
  
  def ensure_login
    google_token = params[:google_token]
    unless google_token
      render json: {errors: ['Missing access token']}, status: :unauthorized
      return false
    end
    
    @current_user = User.find_or_create_for_google_token(google_token)
    if @current_user
      sign_in @current_user
    else
      render json: {errors: ['Invalid access token']}, status: :unauthorized
      return false
    end    
  end
  
  def current_user
    @current_user
  end  
end
