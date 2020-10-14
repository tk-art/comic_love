require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'All Users' do
    let!(:michael) { create(:user) }
    let!(:user)    { create_list(:user, 20) }

    before do
      sign_in(michael.email, michael.password)
      michael.image = fixture_file_upload('/files/default.jpg')
      user.each do |u|
        u.image = fixture_file_upload('/files/default.jpg')
      end
    end

    it '全てのユーザーを表示する、ドロップダウンのリンクが期待通り動作する' do
      visit root_path
      click_on 'My Page'
      click_on 'ユーザー'
      expect(current_path).to eq users_path
    end

    it '全てのユーザーが15以上ならページネーションを使用して、表示されている' do
      expect(User.count).to eq 21
      visit users_path
      expect(page).to have_css '.pagination'
      expect(page).to have_css '.icon2', count: 15
      click_on '2'
      expect(page).to have_css '.icon2', count: 6
    end
  end
end
