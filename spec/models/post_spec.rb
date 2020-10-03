require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'post validation' do
    let(:post) { create(:post) }

    it 'validationが全て通れば有効' do
      expect(post).to be_valid
    end

    it 'user_idがなければ、無効' do
      post.user_id = ''
      expect(post).not_to be_valid
    end

    it 'isbnがなければ、無効' do
      post.isbn = ''
      expect(post).not_to be_valid
    end

    it 'titleがなければ、無効' do
      post.title = ''
      expect(post).not_to be_valid
    end

    it 'image_urlがなければ、無効' do
      post.image_url = ''
      expect(post).not_to be_valid
    end

    it 'urlがなければ、無効' do
      post.url = ''
      expect(post).not_to be_valid
    end

    it 'contentがなければ、無効' do
      post.content = ''
      expect(post).not_to be_valid
    end

    it 'contentが150文字以上なら、無効' do
      post.content = 'a' * 151
      expect(post).not_to be_valid
    end
  end
end
