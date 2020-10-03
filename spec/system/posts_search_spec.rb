require 'rails_helper'

RSpec.describe 'Post', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in(user.email, user.password)
    visit search_path
  end

  describe 'search page' do
    it 'ログインしていないと、ヘッダーに投稿するリンクが表示されない' do
      find('.dropdown-toggle').click
      click_on 'ログアウト'
      expect(page).not_to have_link '投稿する'
    end

    it 'ヘッダーの投稿するを押したら、search pageに移動する' do
      visit root_path
      click_on '投稿する'
      expect(current_path).to eq search_path
    end

    describe 'search item' do
      before do
        fill_in 'keyword', with: '刃牙'
        click_on '漫画を検索'
      end

      it '検索フォームにtitleを入力すると、候補が20個出てくる' do
        expect(page).to have_css '.item-title',    count: 20
        expect(page).to have_css '.item-imageurl', count: 20
        expect(page).to have_css '.item-url',      count: 20
        expect(page).to have_css '.item-isbn',     count: 20
      end

      it '何も入力せずに検索すると、検索ページにレンダリングされる' do
        fill_in 'keyword', with: ''
        click_on '漫画を検索'
        expect(current_path).to eq search_path
      end

      it 'hidden_fieldに値がセットされていること' do
        within first('.item-search') do
          expect(find('.hidden-isbn', visible: false).value).to eq '9784309028439'
        end
      end

      context 'hidden_fieldでisbnコードがセットされている時' do
        it '検索候補の中のsaveを押すと、本投稿ページに移動する' do
          within first('.item-search') do
            click_on 'save'
            expect(current_path).to eq new_post_path
          end
        end

        it 'isbnコードが13文字ではないなら、saveが表示されない' do
          within first('.item-search') do
            find('.hidden-isbn', visible: false).set('123456789')
            expect(page).not_to have_content 'save'
          end
        end
      end

      context 'hidden_fieldに値がセットされていない時' do
        it '検索候補の中のsaveが表示されない' do
          within first('.item-search') do
            find('.hidden-isbn', visible: false).set('')
            expect(page).not_to have_content 'save'
          end
        end
      end
    end
  end
end
