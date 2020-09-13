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
end
