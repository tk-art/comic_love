require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'Sign In' do
    let(:user) { create(:user) }

    describe 'guest user login' do
      let!(:user1) { create(:user, email: 'ta1.pioneer.t@gmail.com') }

      before do
        visit root_path
        user1.image = fixture_file_upload('/files/default.jpg')
        click_link 'ゲストログイン'
      end

      it 'ゲストログインリンクを押すと、ログインできる' do
        expect(page).to have_content 'ゲストユーザーとしてログインしました！'
      end

      it 'アカウント削除,編集ができない' do
        visit user_path(user1)
        click_on 'アカウントを削除する'
        expect(page).to have_content 'ゲストユーザーの編集、削除はできません！'
        visit user_path(user1)
        click_on 'プロフィールを編集する'
        fill_in 'email', with: 'kkk@g.com'
        click_on '更新する'
        expect(page).to have_content 'ゲストユーザーの編集、削除はできません！'
      end
    end

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
