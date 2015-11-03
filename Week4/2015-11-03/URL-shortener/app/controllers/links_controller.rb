class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    original = params[:link][:original_link]
    if Link.check_for_existing(original).nil?
      @link = Link.create(original_link: Link.check_for_http(original), modified_link: Link.generate_url)
    else
      @link = Link.check_for_existing(original)
    end
    render "shared/shortened"
  end

  def recent_ten
    @links = Link.recent_ten
  end

end
