# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
  { name: 'A. Abed', email: 'abed@gmail.com', password: 'abed@gmail.com', password_confirmation: 'abed@gmail.com', admin: true, confirmed_at: Time.zone.now },
  { name: 'Sumail Hassan', email: 'sumail@google.com', password: 'sumail@google.com', password_confirmation: 'sumail@google.com', confirmed_at: Time.zone.now },
  { name: 'Musawer Khan', email: 'khan.musawer@yahoo.com', password: 'khan@yahoo.com', password_confirmation: 'khan@yahoo.com', confirmed_at: Time.zone.now }
])

posts = Post.create([
  { title: 'Test 1', body: '1 asdf qwertabed@gmail.comasdf qwert', user_id: users[0].id },
  { title: 'Another post', body: '2 asdf qwertsumail@google.com', user_id: users[0].id },
  { title: 'sample post', body: '3 asdf qwertkhan.musawer@yahoo.com', user_id: users[2].id }
])

50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    confirmed_at: Time.zone.now
  )
end

User.order(:created_at).take(6).each do |u|
  50.times do |n|
    u.posts.create!(
      title: "Generated post ##{n}", body: Faker::Lorem.sentence(word_count: 6)
    )
  end
end

# Following relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }