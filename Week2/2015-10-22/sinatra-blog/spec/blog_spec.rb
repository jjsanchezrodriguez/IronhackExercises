require_relative '../lib/blog'
require_relative '../lib/post'
require 'pry'

RSpec.describe "Blog model" do

  before :each do
    @blog = Blog.new
  end

  it "posts attribute returns an array of posts" do
    expect(@blog.posts).to be_a Array
  end

  it "Post model will have attr PID assigned after adding" do
    @blog.add_post(Post.new("Haha", "what??", "Ondrej", "blog"))
    @blog.add_post(Post.new("Test", "test text", "Someone", "sponsored"))
    # counts from one
    expect(@blog.posts[1].pid).to eq(2)
  end

  it "#add_post returns two posts models the posts attribute contains two items" do
    @blog.add_post(Post.new("Haha", "what??", "Ondrej", "blog"))
    @blog.add_post(Post.new("Test", "test text", "Someone", "sponsored"))
    expect(@blog.posts[0]).to be_a Post
    expect(@blog.posts.size).to eq 2
  end

  it "#latest_posts lists posts in chronological order" do
    @blog.add_post(Post.new("Haha", "what??", "Ondrej", "blog"))
    @blog.add_post(Post.new("Test", "test text", "Someone", "sponsored"))
    @blog.add_post(Post.new("Bar", "what??", "Ondrej", "blog"))
    @blog.add_post(Post.new("Foo", "test text", "Someone", "sponsored"))
    # adjust the time to go in future
    @blog.posts[3].instance_variable_set(:@date, Time.now + 7000)
    expect(@blog.latest_posts[0].title).to eq("Foo")
    
  end
end
