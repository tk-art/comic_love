require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe '#create_notification_follow!' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    it 'followに対して、notificationモデルにsaveされる' do
      user.follow(other_user)
      other_user.create_notification_follow!(user)
      expect(
        Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', user.id, other_user.id, 'follow'])
      ).to be_truthy
    end
  end

  describe '#create_notification_comment!' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:other_user1) { create(:user) }
    let(:post) { create(:post) }
    let!(:comment) { Comment.create(user_id: other_user.id, post_id: post.id, content: 'ii') }
    let!(:comment1) { Comment.create(user_id: user.id, post_id: post.id, content: 'ee') }

    it 'commentに対して、notificationモデルにsaveされる' do
      post.save_notification_comment!(other_user, comment.id, post.user.id)
      expect(
        Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and
              comment_id = ? and action = ? ', other_user.id, post.user.id, post.id, comment.id, 'comment'])
      ).to be_truthy
    end

    it 'コメントした側と、コメントされた投稿を持つ側が同じならcheckedカラムがtrueになる' do
      post.save_notification_comment!(user, comment1.id, post.user.id)
      expect(
        Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and
          comment_id = ? and action = ? and checked = ?', user.id, post.user.id, post.id, comment1.id, 'comment', 'true'])
      ).to be_truthy
    end
  end
end
