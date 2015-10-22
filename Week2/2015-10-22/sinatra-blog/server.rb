require 'sinatra'
require_relative './lib/blog'
require_relative './lib/post'
require 'pry'

blog = Blog.new

get "/" do
  @posts = blog.latest_posts
  erb :home
end

get "/post/:pid" do
  id = params[:pid].to_i
  @post = blog.posts.find { |post| post.pid == id } 
  erb :post
end

get "/new" do
  erb :new
end

post "/posted" do
  blog.add_post(Post.new(params[:blogtitle], params[:blogpost], params[:blogauthor], params[:blogcategory]))
  redirect "/"
end

