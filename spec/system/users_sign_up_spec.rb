require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'Sign Up' do
    let(:user) { create(:user) }

    it '有効な値が入力されたら、ユーザー数が増える' do
      expect do
        sign_up_with(user.name,
                     user.email,
                     user.password,
                     user.password_confirmation)
      end.to change(User, :count).by(1)
    end

    it '名前が空なら、エラーメッセージが表示される' do
      sign_up_with('', user.email, user.password, user.password_confirmation)
      expect(page).to have_content '名前が入力されていません'
    end

    it 'メールアドレスが空なら、エラーメッセージが表示される' do
      sign_up_with(user.name, '', user.password, user.password_confirmation)
      expect(page).to have_content 'メールアドレスが入力されていません'
    end

    it 'パスワードが空なら、エラーメッセージが表示される' do
      sign_up_with(user.name, user.email, '', '')
      expect(page).to have_content 'パスワードが入力されていません'
    end

    it 'パスワードが6文字以下の時、エラーメッセージが表示される' do
      sign_up_with(user.name, user.email, 'foo', 'foo')
      expect(page).to have_content 'パスワードは6文字以上に設定して下さい。'
    end

    it 'パスワードが一致しない時、、エラーメッセージが表示される' do
      sign_up_with(user.name, user.email, 'foobar', 'foofoo')
      expect(page).to have_content 'パスワード確認値とパスワードの入力が一致しません'
    end
  end
end
