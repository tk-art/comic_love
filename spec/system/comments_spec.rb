require 'rails_helper'

RSpec.describe 'Comment', type: :system do
  describe 'post comment' do
    let(:user)    { create(:user) }
    let(:post)    { create(:post) }
    let(:comment) { post.comments.first }

    before do
      sign_in(user.email, user.password)
      visit post_path(post.id)
    end

    it 'コメントすることができる' do
      expect(page).to have_button 'コメントする'
      fill_in 'comment-form', with: 'テスト'
      click_on 'コメントする'
      within '.comments' do
        expect(page).to have_link user.name
        expect(page).to have_content 'テスト'
      end
    end

    it '空はコメントできない' do
      fill_in 'comment-form', with: ''
      within '.comments' do
        expect(page).not_to have_link user.name
      end
    end
  end
end
