require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'Sign In' do
    let(:user) { create(:user) }

    context '有効な値が入力された場合' do
      it 'rootに飛んで、flashが表示され、ログインが完了する' do
        sign_in(user.email, user.password)
        expect(current_path).to eq root_path
        expect(page).to have_content 'ログインしました'
        expect(page).to have_css '.dropdown'
      end
    end

    context '有効な値が入力されなかった場合' do
      it 'flashが表示され、ログインが完了しない' do
        sign_in('', '')
        expect(current_path).to eq user_session_path
        expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'
      end
    end

    it 'ログインを記憶するチェックボックスが表示されている' do
      visit new_user_session_path
      expect(page).to have_field 'ログインを記憶する'
    end

    it '新規登録がまだの方用のリンクが表示されている' do
      visit new_user_session_path
      expect(page).to have_link 'こちら'
    end
  end

  describe 'Log out' do
    let(:user) { create(:user) }

    it 'ログインしていないと、ログアウトのドロップダウンが表示されない' do
      visit root_path
      expect(page).not_to have_css '.dropdown-toggle'
    end

    it 'ログアウトが完了すると、rootに戻る' do
      sign_in(user.email, user.password)
      find('.dropdown-toggle').click
      click_on 'ログアウト'
      expect(current_path).to eq root_path
      expect(page).to have_content 'ログアウトしました。'
    end
  end
end
