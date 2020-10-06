FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "takumi_#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password { 'foobar' }
    password_confirmation { 'foobar' }
    image { File.open('./spec/fixtures/files/default.jpg', 'r') }
    profile { 'はじめたばかりなので、宜しく' }
  end

  factory :post do
    user_id { user.id.to_s }
    title { '『グラップラー刃牙』はBLではないかと1日30時間300日考えた乙女の記録ッッ' }
    image_url { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/8439/9784309028439.jpg?_ex=200x200' }
    url { 'https://books.rakuten.co.jp/rb/16091894/' }
    isbn { '9784309028439' }
    content { '面白い！' }
    association :user
    after(:create) do |post|
      category = build(:category)
      category1 = build(:category1)
      post.post_categories << build(:post_category, post: post, category: category)
      post.post_categories << build(:post_category, post: create(:post1), category: category1)
    end
  end

  factory :post1, class: Post do
    user_id { user.id.to_s }
    title { '慎重勇者' }
    image_url { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/0075/9784040640075.jpg?_ex=200x200' }
    url { 'https://books.rakuten.co.jp/rb/16091894/' }
    isbn { '9784309028439' }
    content { '面白い！' }
    association :user
  end

  factory :category do
    name { 'ファンタジー' }
  end

  factory :category1, class: Category do
    name { 'ギャグ' }
  end

  factory :post_category do
    post
    category
  end
end
