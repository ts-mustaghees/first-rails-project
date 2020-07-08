# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
    { name: 'A. Abed', email: 'abed@gmail.com' },
    { name: 'Sumail Hassan', email: 'sumail@google.com' },
    { name: 'Musawer Khan', email: 'khan.musawer@yahoo.com' }
])

posts = Post.create([
    { title: 'Test 1', body: '1 asdf qwertabed@gmail.comasdf qwert', user_id: users[0].id },
    { title: 'Another post', body: '2 asdf qwertsumail@google.com', user_id: users[0].id },
    { title: 'sample post', body: '3 asdf qwertkhan.musawer@yahoo.com', user_id: users[2].id }
])