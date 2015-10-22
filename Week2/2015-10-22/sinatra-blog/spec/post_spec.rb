require_relative '../lib/post'

RSpec.describe "Post model" do

  before :all do
    @post = Post.new("Foo", "Bar Bar", "Ondrej", "blog")
  end

  it "title attribute returns the string we initiliazed it with and is of class String" do
    expect(@post.title).to be_a String
    expect(@post.title).to eq "Foo"
  end

  it "text attribute returns the string we initiliazed it with and is of class String" do
    expect(@post.text).to be_a String
    expect(@post.text).to eq "Bar Bar"
  end

  it "date attribute is of class Time" do
    expect(@post.date).to be_a Time
  end

  it "author and category attribute should be of class String and right parameters" do
    expect(@post.author).to eq("Ondrej")
    expect(@post.category).to eq("blog")
    expect(@post.author).to be_a String
    expect(@post.category).to be_a String
  end
end

