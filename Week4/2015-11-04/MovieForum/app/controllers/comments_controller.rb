class CommentsController < ApplicationController
  def new
    @movie = Movie.find_by(id: params[:movie_id].to_i)
    @comment = Comment.new
    if @movie.nil?
      @movie = Movie.create_from_imdb(params[:movie_id])
    end
  end

  def create
    comment = Comment.create(movie_id: safe_comment_params[:real_movie_id], comment: safe_comment_params[:comment])
    redirect_to movie_path(comment.movie_id)
  end

  private

  def safe_comment_params
    params.require(:comment).permit(:comment, :real_movie_id)
  end
end
