FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "takumi_#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password { 'foobar' }
    password_confirmation { 'foobar' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/default.jpg')) }
    profile { 'はじめたばかりなので、宜しく' }
  end
end
