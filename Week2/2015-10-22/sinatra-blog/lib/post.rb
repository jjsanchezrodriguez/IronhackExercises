require 'date'

class Post
  attr_reader :title, :date, :text, :author, :category
  attr_accessor :pid
  def initialize(title, text, author, category)
    @pid = nil
    @title = title
    @date = Time.now
    @text = text
    @author = author
    @category = category
  end
end
