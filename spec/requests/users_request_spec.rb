require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /sign_up' do
    it 'レスポンスが正常であること' do
      get new_user_registration_path
      expect(response).to be_success
      expect(response).to have_http_status '200'
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
