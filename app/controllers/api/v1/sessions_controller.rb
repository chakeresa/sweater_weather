class Api::V1::SessionsController < ApplicationController
  def create
    email_entered = params[:email]
    return unauthorized unless email_entered
    
    user = User.find_by(email: email_entered.downcase)
    if user && user.authenticate(params[:password])
      render json: { api_key: user.api_key }
    else
      unauthorized
    end
  end

  private

  def unauthorized
    render status: :unauthorized, json: { error: 'Incorrect username/password combination' }
  end
end
