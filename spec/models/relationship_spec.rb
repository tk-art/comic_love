require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:relationship) { Relationship.new(follower_id: user.id, followed_id: other_user.id) }

  describe 'relationships validates' do
    it 'follower_idが存在しなければ、無効' do
      relationship.follower_id = ''
      expect(relationship).not_to be_valid
    end

    it 'followed_idが存在しなければ、無効' do
      relationship.followed_id = ''
      expect(relationship).not_to be_valid
    end
  end

  describe 'follow unfollow' do
    it 'follow unfollowが問題なく行われること' do
      expect(user.following?(other_user)).to be_falsey
      user.follow(other_user)
      expect(user.following?(other_user)).to be_truthy
      expect(other_user.followers.include?(user)).to be_truthy
      user.unfollow(other_user)
      expect(user.following?(other_user)).to be_falsey
    end
  end
end
