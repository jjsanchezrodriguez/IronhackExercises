class Link < ActiveRecord::Base
  def self.create_link(original)
    if Link.check_for_existing(original).nil?
      Link.create(original_link: Link.check_for_http(original), modified_link: Link.generate_url)
    else
      Link.check_for_existing(original)
    end
  end

  def self.generate_url
    str = Link.unique_id (3)
    "http://localhost:3000/#{str}"
  end

  def self.unique_id(num)
    str = ""
    alpha = ('a'..'z').to_a.push(('A'..'Z').to_a).flatten
    num.times do |i|
      str += alpha[rand(alpha.length - 1)]
    end
    return str
  end

  def self.check_for_http(link)
    if link.match(/http:\/\//).nil?
      "http://#{link}"
    else
      link
    end
  end

  def self.check_for_existing(link)
    Link.find_by(original_link: Link.check_for_http(link))
  end

  def self.recent_ten
    Link.order("created_at").limit(10)
  end
end
