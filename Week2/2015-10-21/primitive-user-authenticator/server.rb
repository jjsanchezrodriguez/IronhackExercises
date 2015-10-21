require 'sinatra'
require 'sinatra/reloader'
require 'pry' if development?
require_relative 'models/Authenticator'

enable(:sessions)

set :environment, :development
set :warning, false

get "/log_in" do
  if session[:logged_in]
    redirect "/profile"
  end

  if session[:warning]
    @warning = "Wrong input"
  end

  erb :log_in
end

post "/log_in" do

  session[:username] = params[:username]
  session[:password] = params[:password]

  if Authenticator.new(session[:username], session[:password]).valid?
    session[:logged_in] = true 
    session[:warning] = false 
    redirect "/profile"
  else
    session[:logged_in] = false 
    session[:warning] = true
    redirect "/log_in"
  end
end

get "/profile" do
  if session[:logged_in]
    @username = session[:username]
    @password = session[:password]
    erb :profile
  else
    redirect "/log_in"
  end
end

post "/log_out" do
  session[:logged_in] = false
  redirect "/log_in"
end

