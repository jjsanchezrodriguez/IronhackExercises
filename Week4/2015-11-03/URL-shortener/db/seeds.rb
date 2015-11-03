# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Link.destroy_all

urls = ['google.com',
        'nyx.cz',
        'carpet.com',
        'espana.es',
        'foo.bar',
        'el.pel',
        'sausage.eg',
        'come.here',
        'wind.co',
        'hello.ok',
        'crap.com',
        'dog.com',
        'see.me',
        'for.me',
        'hello.there',
        'haha.no',
        'seznam.cz',
        'pend.com',
        'fontbar.com',
        'fight.com'
]

20.times do |i|
  link = Link.check_for_http("www.#{urls[i]}")
  Link.create(original_link: link, modified_link: Link.generate_url) 
end

puts "--- clean DB ---"
