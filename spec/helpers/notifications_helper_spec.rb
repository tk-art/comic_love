require 'rails_helper'

RSpec.describe NotificationsHelper, type: :helper do
  describe '#unchecked_notifications' do
    let(:current_user)  { create(:user) }
    let(:other_user)    { create(:user) }
    let(:other_user1)   { create(:user) }
    let!(:notification) do
      Notification.create(visitor_id: other_user.id, visited_id: current_user.id, action: 'follow')
    end
    let!(:notification1) do
      Notification.create(visitor_id: other_user1.id, visited_id: current_user.id, action: 'follow', checked: 'true')
    end

    it 'checkedがfalseの値だけ取ってくる' do
      expect(unchecked_notifications.count).to eq 1
    end
  end
end
