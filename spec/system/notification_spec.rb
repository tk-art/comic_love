require 'rails_helper'

RSpec.describe 'Notification' do
  describe 'comment follow notification' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    before do
      sign_in(post.user.email, post.user.password)
    end

    it '通知リンクを踏むと、通知一覧ページに移動する' do
      visit root_path
      click_on '通知'
      expect(current_path).to eq notifications_path
    end

    it 'followされたら、通知を受け取る' do
      visit user_path(user)
      click_on 'Follow'
      find('.dropdown-toggle').click
      click_on 'ログアウト'
      sign_in(user.email, user.password)
      click_on '通知'
      expect(page).to have_content "#{post.user.name}さんが あなたをフォローしました"
    end

    # it 'commentされたら、通知を受け取る' do
    #   sign_in(user1.email, user1.password)
    #   visit post_path(post.id)
    #   fill_in 'comment-form', with: 'コメントテスト'
    #   click_on 'コメントする'
    #   find('.dropdown-toggle').click
    #   click_on 'ログアウト'
    #   sign_in(user.email, user.password)
    #   click_on '通知'
    #   expect(page).to have_content "#{user1.name}さんが あなたの投稿にコメントしました"
    #   expect(page).to have_content 'コメントテスト'
    # end
  end
end
