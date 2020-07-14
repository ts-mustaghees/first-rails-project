# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
  { name: 'A. Abed', email: 'abed@gmail.com', password: 'abed@gmail.com', password_confirmation: 'abed@gmail.com', admin: true },
  { name: 'Sumail Hassan', email: 'sumail@google.com', password: 'sumail@google.com', password_confirmation: 'sumail@google.com' },
  { name: 'Musawer Khan', email: 'khan.musawer@yahoo.com', password: 'khan@yahoo.com', password_confirmation: 'khan@yahoo.com' }
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
    password_confirmation: password
  )
end