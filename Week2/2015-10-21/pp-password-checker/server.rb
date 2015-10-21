require 'sinatra'
require 'sinatra/reloader'
require_relative 'models/PasswordChecker'

enable :sessions
set :warning, false

get "/" do
  if session[:warning]
    @warning = "Wrong credentials"
  end
  erb :home
end

post "/login" do
  email = params[:email]
  password = params[:pass]

  if PasswordChecker.new.check_password(email, password)
    session[:passed] = true
    session[:warning] = false
    redirect "/congratulations"
  else
    session[:passed] = false
    session[:warning] = true 
    redirect "/"
  end
end

get "/congratulations" do
  if session[:passed]
    erb :congrats
  else
    redirect "/"
  end
end

post "/logout" do
  session[:passed] = false
  redirect "/"
end
