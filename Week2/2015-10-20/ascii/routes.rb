require 'sinatra'
require 'sinatra/reloader'
require 'artii'

get "/" do
  "hello world"
end

get "/ascii/?:animal?/?:font?/:word" do 
  str = params[:word]
  if params[:font].nil?
    a = Artii::Base.new :font => 'slant'
  elsif params[:font] == 'special' && params[:animal] == 'hippo' && params[:word] == 'secret'
    redirect "/looooool"
  else
    a = Artii::Base.new :font => params[:font]
  end

  @output = a.asciify(str)
  erb :ascii
end

get "/looooool" do
  # /ascii/hippo/special/secret
  erb :hippo
end
