require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require_relative './models/Calculator'

get "/" do
  erb :index
end

post "/result" do
  @params = params
  @calc = Calculator.new(params[:first], params[:second], params[:operation])
  @result = @calc.calculate

  erb :result
end
