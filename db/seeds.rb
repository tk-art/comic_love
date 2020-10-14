50.times do |n|
  name  = Faker::Name.name
  email = "natu-#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

Category.create(name: '少年漫画')
Category.create(name: '少女漫画')
Category.create(name: 'ギャグ')
Category.create(name: '恋愛')
Category.create(name: 'スポーツ')
Category.create(name: 'アクション')
Category.create(name: 'ホラー')
Category.create(name: 'サスペンス')
Category.create(name: 'ファンタジー')