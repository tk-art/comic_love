require 'rails_helper'

RSpec.describe 'Search', type: :system do
  describe 'search page' do
    let!(:user) { create(:user) }
    let(:other_user)  { create(:user) }
    let!(:malti_user) { create_list(:user, 10, name: 'takumi') }

    before do
      sign_in(user.email, user.password)
      visit searching_path
    end

    it 'ヘッダーのリンクを踏むと、検索ページに飛ぶ' do
      visit root_path
      click_on '検索する'
      expect(current_path).to eq searching_path
    end

    it 'ユーザー名と漫画タイトルを選択することができる' do
      within '.select-search' do
        expect(page).to have_content 'ユーザー名'
        expect(page).to have_content '漫画タイトル'
      end
    end

    context 'ユーザー名で検索する場合' do
      it '検索するとユーザーの検索結果の名前と写真が表示される' do
        fill_in 'search', with: other_user.name
        within '.search-form' do
          click_on '検索する'
        end
        expect(page).to have_content other_user.name
        expect(page).to have_css '.icon3'
        expect(page).not_to have_content user.name
      end

      it '10人以上ヒットすれば、ページネーションが表示される' do
        fill_in 'search', with: 'takumi'
        within '.search-form' do
          click_on '検索する'
        end
        expect(page).to have_css '.pagination'
      end
    end

    context '漫画タイトルで検索する場合', js: true do
      let(:post)        { create(:post) }
      let(:post1)       { create(:post1) }
      let!(:malti_post) { create_list(:post, 11) }

      it '検索すると、一致した投稿が表示される' do
        find('.select-search').click
        find('option', text: '漫画タイトル').click
        fill_in 'search', with: post1.title
        within '.search-form' do
          click_on '検索する'
        end
        expect(page).to have_content post1.title
        expect(page).to have_css '.item-image'
        expect(page).not_to have_content post.title
      end

      it '10以上投稿がヒットすれば、ページネーションが表示される' do
        find('.select-search').click
        find('option', text: '漫画タイトル').click
        fill_in 'search', with: post.title
        within '.search-form' do
          click_on '検索する'
        end
        expect(page).to have_css '.pagination'
      end
    end
  end
end
