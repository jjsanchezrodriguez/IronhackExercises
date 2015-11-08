class MoviesController < ApplicationController
  def search
    @movies = Movie.search_by_title(search_safe_params)
  end

  def show
    @movie = Movie.find_by(id: params[:id])
  end

  private
  def search_safe_params
    params.require(:movie)
  end
end
