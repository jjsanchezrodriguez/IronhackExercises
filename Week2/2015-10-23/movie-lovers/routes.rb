require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/crawler'
require 'pry'

crawler = Crawler.new()
enable :sessions
set :session, :finished => false, :score => 0

QUESTIONS = [
  :what_year?, :directed_by?, :what_actor?
]

get "/" do
  unless crawler.titles.empty?
    @movies = crawler.titles
    crawler.send(QUESTIONS[rand(QUESTIONS.size)])
    @question = crawler.question
    @answer = crawler.answer
  end

  session[:finished] ? session[:score] = 0 : session[:score]

  @score = session[:score].to_s
  erb :home
end

get "/answer/:id" do
  if params[:id] == crawler.answer
    session[:score] += 1
    redirect "/correct"
  else
    redirect "/wrong"
  end
end

post "/search" do
  crawler.titles.clear
  crawler.query = params[:query]
  crawler.crawl
  redirect "/"
end

get "/correct" do
  session[:finished] ? session[:finished] = false : session[:finished]
  @right = crawler.random.title
  erb :correct
end

get "/wrong" do
  
  session[:finished] ? session[:finished] = false : session[:finished]
  erb :wrong
end

get "/end" do
  @score = session[:score].to_s
  session[:finished] = true
  erb :done
end


