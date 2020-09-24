require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /sign_up' do
    let(:user) { create(:user) }

    it 'レスポンスが正常であること' do
      get new_user_registration_path
      expect(response).to be_success
      expect(response).to have_http_status '200'
    end

    it '有効な値が入力されたら、ユーザー数が増える' do
      expect do
        post user_registration_path, params: { name: user.name,
                                               email: user.email,
                                               password: user.password,
                                               password_confirmation: user.password_confirmation }
      end.to change(User, :count).by(1)
    end
  end

  describe 'GET /sign_in' do
    it 'レスポンスが正常であること' do
      get user_session_path
      expect(response).to be_success
      expect(response).to have_http_status '200'
    end
  end
end
