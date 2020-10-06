require 'rails_helper'

RSpec.describe 'Category', type: :system do
  describe 'Category function' do
    let(:user)    { create(:user) }
    let!(:post)   { create(:post) }
    let!(:post1)  { create(:post1) }

    before do
      sign_in(user.email, user.password)
      visit root_path
    end

    it 'サイドバーにカテゴリの一覧が表示されている' do
      expect(page).to have_css '.ca-name', count: 2
    end

    it 'カテゴリーリンクを踏むと、そのカテゴリーに属する投稿がでる' do
      expect(page).to have_content 'ファンタジー'
      click_on 'ファンタジー'
      expect(page).to have_content post.title
      expect(page).not_to have_content post1.title
    end

    it '投稿詳細では、投稿が属するカテゴリー名が表示されている' do
      visit post_path(post.id)
      post.categories.each do |category|
        expect(page).to have_content category.name
      end
    end
  end
end
