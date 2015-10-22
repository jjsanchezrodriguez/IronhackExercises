class Blog
  @@counter = 1
  attr_accessor :posts
  def initialize
    @posts = []
  end

  def add_post(post)
    post.pid = @@counter
    @posts << post
    @@counter += 1
  end

  def latest_posts
    @posts.sort do |post1, post2|
      post2.date <=> post1.date
    end
  end
end 
