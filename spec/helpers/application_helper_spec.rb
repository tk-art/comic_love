require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    subject { full_title(page_title: title) }

    context 'titleに文字列が渡された場合' do
      let(:title) { 'Ruby on Rails Tote' }

      it { is_expected.to eq 'Ruby on Rails Tote - Comic Share' }
    end

    context 'nilが与えられた場合' do
      let(:title) { nil }

      it { is_expected.to eq 'Comic Share' }
    end

    context '空文字が与えられた場合' do
      let(:title) { '' }

      it { is_expected.to eq 'Comic Share' }
    end

    context '引数がない場合' do
      it { expect(full_title).to eq 'Comic Share' }
    end
  end

  describe '#current_user?' do
    let(:current_user) { create(:user) }
    let(:user) { create(:user) }

    it 'userがnilの場合、nilがかえって失敗する' do
      user = nil
      expect(current_user?(user)).to eq nil
    end

    it '引数として与えられたuserとログイン済みのcurrent_userが一致しなければ失敗する' do
      expect(current_user?(user)).to be_falsey
    end

    it '引数として与えられたuserとログイン済みのcurrent_userが一致すれば成功する' do
      user = current_user
      expect(current_user?(user)).to be_truthy
    end
  end
end
