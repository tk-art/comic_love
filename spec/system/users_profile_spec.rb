require 'rails_helper'

RSpec.describe 'Profile', type: :system do
  describe 'profile page' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    before do
      sign_in(user.email, user.password)
      visit user_path(user.id)
    end

    it '期待される名前、写真、プロフィールが表示されていること' do
      expect(page).to have_content user.name
      expect(page).to have_content user.profile
      expect(page).to have_selector 'img[alt="icon-image"]'
    end

    it 'current user以外のプロフィールページには、編集、削除リンクが表示されていない' do
      expect(page).to have_link 'プロフィールを編集する'
      expect(page).to have_link 'アカウントを削除する'
      visit user_path(other_user.id)
      expect(page).not_to have_link 'プロフィールを編集する'
      expect(page).not_to have_link 'アカウントを削除する'
    end

    it '編集用のリンクを踏むと、プロフィール編集ページに移動する' do
      click_link 'プロフィールを編集する'
      expect(current_path).to eq edit_user_registration_path
    end

    it '削除リンクを踏むと、ログインページに戻され、再度同じアカウントでのログインができなくなる' do
      click_link 'アカウントを削除する'
      expect(current_path).to eq root_path
      expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
      visit new_user_session_path
      sign_in(user.email, user.password)
      expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'
    end
  end
end
