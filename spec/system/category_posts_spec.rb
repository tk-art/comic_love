require 'rails_helper'

RSpec.describe 'Category', type: :system do
  describe 'Category function' do
    let(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:category1) { create(:category, :category1) }
    let!(:post)   { create(:post, category_ids: [category.id]) }
    let!(:post1)  { create(:post, category_ids: [category.id]) }
    let!(:post2)  { create(:post, category_ids: [category.id]) }
    let!(:post3)  { create(:post, category_ids: [category.id]) }
    let!(:post4)  { create(:post, category_ids: [category.id]) }
    let!(:post5)  { create(:post, category_ids: [category.id]) }

    before do
      sign_in(user.email, user.password)
      visit root_path
    end

    it 'サイドバーにカテゴリの一覧が表示されている' do
      expect(page).to have_css '.ca-name', count: 2
    end

    it 'カテゴリーリンクを踏むと、そのカテゴリーに属する投稿がでる' do
      click_on category.name
      expect(page).to have_content "カテゴリー（#{category.name})"
    end

    it '投稿詳細では、投稿が属するカテゴリー名が表示されている' do
      visit post_path(post.id)
      post.categories.each do |category|
        expect(page).to have_content category.name
      end
    end

    it '投稿詳細で表示されているカテゴリー名を押すと、カテゴリーページに移動する' do
      visit post_path(post.id)
      post.categories.each do |category|
        click_on category.name
        expect(current_path).to eq category_path(category.id)
      end
    end

    it '投稿された漫画に関連する漫画が4つまで表示され,自分は含まれない' do
      visit post_path(post.id)
      within '.category-posts' do
        expect(page).to have_css '.category-post', count: 4
        expect(page).not_to have_selector '.category_post', text: post.title
      end
    end
  end
end
