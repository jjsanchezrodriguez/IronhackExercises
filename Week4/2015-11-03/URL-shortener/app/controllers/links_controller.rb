class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.create_link(params[:link][:original_link])
    render "shared/shortened"
  end

  def recent_ten
    @links = Link.recent_ten
  end

end
