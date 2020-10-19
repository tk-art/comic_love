require 'rails_helper'

RSpec.describe 'Notification' do
  describe 'comment follow notification' do
    let(:user) { create(:user) }
    let(:user1) { create(:user) }
    let!(:post) { create(:post, user_id: user.id) }
    let(:comment) { Comment.create(user_id: user1.id, post_id: post.id, content: 'コメントテスト') }
    let!(:notification) do
      Notification.create(visitor_id: user1.id, visited_id: user.id, post_id: post.id,
                          comment_id: comment.id, action: 'comment')
    end

    before do
      sign_in(user1.email, user1.password)
      user.image = fixture_file_upload('/files/default.jpg')
      user1.image = fixture_file_upload('/files/default.jpg')
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
      expect(page).to have_content "#{user1.name}さんが あなたをフォローしました"
    end

    context 'comment' do
      before do
        find('.dropdown-toggle').click
        click_on 'ログアウト'
        sign_in(user.email, user.password)
      end

      it 'commentされたら、通知を受け取る' do
        click_on '通知'
        expect(page).to have_content "#{user1.name}さんが あなたの投稿にコメントしました"
        expect(page).to have_content 'コメントテスト'
      end

      it '通知未確認であれば、リンク側にマークがでる' do
        within '.notification-icon' do
          expect(page).to have_css '.n-circle'
        end
        click_on '通知'
        within '.notification-icon' do
          expect(page).not_to have_css '.n-circle'
        end
      end

      it '通知の削除が可能である' do
        click_on '通知'
        click_on '全件削除'
        expect(page).not_to have_content 'コメントテスト'
      end
    end
  end
end
