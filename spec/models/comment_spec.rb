require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { post.comments.first }
  it 'contentがなければ、無効' do
    expect(comment).not_to eq be_valid
  end
  it 'contentが140文字以上なら、無効' do
    comment.content = 'a' * 141
    expect(comment).not_to be_valid
  end
end
