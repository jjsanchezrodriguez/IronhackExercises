ENV['RACK_ENV'] = 'test'

# sinatra app
require_relative '../server'
require 'rspec'
require 'rack/test'

describe "Sinatra-blog Views" do

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before :each do
    @blog = Blog.new
  end

  it "index hits 200" do
    get "/"
    expect(last_response).to be_ok
  end

  it "without blog posts get at least some HTML" do
    get "/"
    expect(last_response.body.nil?).to be_falsey 
  end

  it "new hits 200" do
    get "/new"
    expect(last_response).to be_ok
  end

end
