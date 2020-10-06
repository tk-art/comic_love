require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  it '検索ページが正常であること' do
    get search_path
    expect(response.status).to eq 200
  end
end
