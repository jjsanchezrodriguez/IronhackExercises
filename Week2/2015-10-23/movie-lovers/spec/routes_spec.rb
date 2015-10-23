ENV['RACK_ENV'] = 'test'

require_relative '../routes'
require 'rspec'
require 'rack/test'
require 'pry'

describe "Routes" do

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "hits 200" do
    get "/"
    expect(last_response).to be_ok
  end

  it "submit routes to /search, / gets updated with images" do
    post "/search", :query => 'Star Wars'
    get "/"
    expect(last_response).to be_ok
    expect(last_response.body.include?('img')).to be_truthy
  end

end
