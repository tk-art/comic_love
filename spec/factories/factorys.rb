FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "takumi_#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password { 'foobar' }
    password_confirmation { 'foobar' }
    profile { 'はじめたばかりなので、宜しく' }
  end

  factory :post do
    sequence(:title) { |t| "title_#{t}" }
    image_url { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/8439/9784309028439.jpg?_ex=200x200' }
    url { 'https://books.rakuten.co.jp/rb/16091894/' }
    isbn { '9784309028439' }
    content { '面白い！' }
    association :user
    after(:create) do |post|
      create(:comment, user: create(:user), post: post)
    end
  end

  factory :category do
    name { 'ファンタジー' }
    trait :category1 do
      name { 'ギャグ' }
    end
  end

  factory :comment do
    user
    post
    content { '最高に面白い' }
  end
end
