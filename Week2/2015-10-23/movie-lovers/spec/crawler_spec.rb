require_relative '../lib/crawler'
require 'pry'
require 'rspec'

RSpec.describe Crawler do

    before :each do
      @q = Crawler.new
    end

  it "#crawl should fetch nine titles" do
    @q.query = 'Star Wars'
    @q.crawl
    expect(@q.titles.size).to eq(9)
  end

  it "#crawl gets only titles with posters" do
    # mountain returns one empty title
    # http://akas.imdb.com/title/tt4907864/
    @q.query = 'Mountain'
    @q.crawl
    # expecting zero
    has_poster = @q.titles.select { |t| t.poster.nil? }.size
    expect(has_poster).to eq(0)
  end

  it "#directed_by? will ask for director name" do
    @q.query = 'Holy Mountain'
    @q.crawl
    @q.directed_by?
    expect(@q.answer).to eq(@q.random.id)
  end

end
