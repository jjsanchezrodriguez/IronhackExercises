require 'date'
require 'pry'
require 'colorize'

class Blog

  def initialize
    @posts = []
    @pages = []
    @cur_index = 0
  end

  def add_post(post)
    pages_helper
    @pages << post
  end

  def pages_helper(initalized = false)
    if !initalized
      if @pages.size + 1 > 3
        @posts << @pages
        @pages = []
      end
    else
      if !@pages.empty?
        @posts << @pages
        @pages = []
      end
    end
  end

  def prompt
    return gets.chomp.downcase[0]
  end

  def get_page(index)
    @posts[index]
  end

  def sort_posts
    @posts.map! do |triple|
      triple.sort! do |cur_post, next_post|
        cur_post.date <=> next_post.date
      end
    end
  end

  def pagination
    (1..@posts.size).each do |num|
      if num == @cur_index + 1
        print num.to_s.colorize(:red) + " "
      else
        print num.to_s + " "
      end
    end
  end

  def list_helper(forward = true)

    if forward
      if @cur_index + 1 > @posts[@cur_index].size
        @cur_index
      else
        @cur_index += 1
      end
    else
      if @cur_index - 1 < 0
        @cur_index = 0
      else
        @cur_index -= 1
      end
    end

  end

  def printer
    system "clear"
    posts = get_page(@cur_index)
    posts.each do |post|
      if post.class == SponsoredPost
        puts post.title.colorize(:blue)
        puts ('*' * post.title.size).colorize(:blue)
      else
        puts post.title
        puts '*' * post.title.size
      end
      puts post.text
      puts '-' * 20
    end
    pagination
  end

  def list
    pages_helper(initalized = true)
    sort_posts
    printer

    while true
      answer = prompt
      if answer == 'n'
        list_helper
        printer
      elsif answer == 'p'
        list_helper(forward = false)
        printer
      elsif answer == 'q'
        exit(0)
      end
    end
  end

end


class Post

  attr_reader :title, :text, :date

	def initialize (title, text)
		@title = get_title(title)
    sleep(0.1)
		@date = Time.now
		@text = text
	end

  def get_title(title)
    return title
  end

end


class SponsoredPost < Post

  def get_title(title)
    output = "******" + title + "******"
    return output
  end

end

posts = { "Hello" => "How are you?",
          "What is up?" => "This is fun right?",
          "Hahaha!" => "Little blog",
          "Coding coding" => "I'm still coding.",
          "Blog blag" => "This is how you blog",
          "Ruby v. 1000" => "Is the best!",
          "Monkey" => "Hu hu ha ha",
          "Whiskey" => "I like me some"

}

sponsored_posts = {
        "Douchebag" => "Hello this is Donald Trump",
        "Ironhack" => "Pretty cool place"
}


the_blog = Blog.new
posts.each_with_index do |(key, val), index|
  the_blog.add_post( Post.new( key.to_s, posts[key] ) )
end

sponsored_posts.each_with_index do |(key, val), index|
  the_blog.add_post( SponsoredPost.new( key.to_s, sponsored_posts[key] ) )
end

the_blog.list
