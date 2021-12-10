# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

poster = User.find_or_initialize_by(email: "piglet@dog.com")
poster.update!(username: "piglet", password: "pigletisacutedog")
pp "Created user with email #{poster.email}"

viewer = User.find_or_initialize_by(email: "annie@pup.com")
viewer.update!(username: "annie", password: "pigletisacutedog")
pp "Created user with email #{viewer.email}"

topic_1 = Topic.create!(title: "wow how cute am I", author: poster)
topic_2 = Topic.create!(title: "let's talk about piglet", author: viewer)
topic_3 = Topic.create!(title: 'h'*200, author: viewer, posts: [Post.new(body: 'hello', author: viewer)])

3.times do |i|
    Post.create!(body: "#{i}x the cute", author: i.odd? ? poster : viewer, topic: topic_1)
end

Post.create!(body: "don't mind if I do", author: poster, topic: topic_2)
pp "Created some topics with replies"
