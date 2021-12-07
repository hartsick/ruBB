# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

poster = User.find_or_initialize_by(email: "piglet@dog.com")
poster.update(password: "pigletisacutedog")

viewer = User.find_or_initialize_by(email: "annie@pup.com")
viewer.update(password: "pigletisacutedog")

topic = Topic.create(title: "wow how cute am I", author: poster)
3.times do |i|
    Post.create(body: "#{i}x the cute", author: i.odd? ? poster : viewer)
end
