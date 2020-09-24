require 'rails_helper'

RSpec.describe 'Relationship' do
  describe 'follow unfollow ajax' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    before do
      sign_in(user)
    end

    it 'フォローすると、フォロー中のユーザーが増える' do
      expect do
        post relationships_path, params: { followed_id: other_user.id }
      end.to change { user.following.count }.by(1)
    end

    it 'ajaxでフォローしても、フォロー中のユーザーが増える' do
      expect do
        post relationships_path, xhr: true, params: { followed_id: other_user.id }
      end.to change { user.following.count }.by(1)
    end

    it 'フォローを解除すると、フォロー中のユーザーが減る' do
      user.follow(other_user)
      relationship = user.active_relationships.find_by(followed_id: other_user.id)
      expect do
        delete relationship_path(relationship)
      end.to change { user.following.count }.by(-1)
    end

    it 'ajaxでフォローを解除しても、フォロー中のユーザーが減る' do
      user.follow(other_user)
      relationship = user.active_relationships.find_by(followed_id: other_user.id)
      expect do
        delete relationship_path(relationship), xhr: true
      end.to change { user.following.count }.by(-1)
    end
  end
end
