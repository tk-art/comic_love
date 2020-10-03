require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'users validates' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    it 'validationが全て通れば、有効' do
      expect(user).to be_valid
    end

    it '名前がなければ、無効' do
      user.name = ''
      expect(user).not_to be_valid
    end

    it '名前は、30文字以内でなければ無効' do
      user.name = 'a' * 31
      expect(user).not_to be_valid
    end

    it 'メールアドレスがなければ、無効' do
      user.email = ''
      expect(user).not_to be_valid
    end

    it 'メールアドレスは、255文字以内でなければ無効' do
      user.email = 'a' * 256
      expect(user).not_to be_valid
    end

    it 'メールアドレスは、一意でなければ無効' do
      other_user.email = 'n@gmail.com'
      other_user.save
      user.email = 'n@gmail.com'
      expect(user).not_to be_valid
    end

    it 'プロフィールは, 140文字以内でなければ無効' do
      user.profile = 'a' * 141
      expect(user).not_to be_valid
    end
  end
end
