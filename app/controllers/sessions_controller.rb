# frozen_string_literal: true

class SessionsController < ApplicationController
  get "/signup" do
    redirect to "/tweets" if session[:user_id].present?

    erb :"/sessions/signup"
  end

  post "/signup" do
    if params[:username].present? &&
       params[:email].present? &&
       params[:password].present?
      user = User.create(username: params[:username],
                         email: params[:email],
                         password: params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get "/login" do
    redirect to "/tweets" if session[:user_id].present?

    erb :"/sessions/login"
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
    redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get "/logout" do
    # logout user
    redirect to "/index"
  end
end
