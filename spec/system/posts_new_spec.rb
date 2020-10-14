require 'rails_helper'

RSpec.describe 'Post', type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  before do
    sign_in(user.email, user.password)
    user.image = fixture_file_upload('/files/default.jpg')
  end

  describe 'new edit' do
    context '全てのフォームに値が正常に存在している場合' do
      before do
        visit new_post_path
        fill_in 'isbn',      with: post.isbn
        fill_in 'image_url', with: post.image_url
        fill_in 'title',     with: post.title
        fill_in 'url',       with: post.url
        fill_in 'content',   with: post.content
        find('#new-post').click
      end

      it '全てのフォームに値が正常に存在していれば、投稿され、プロフィールページに飛ぶ' do
        expect(current_path).to eq user_path(user)
        expect(page).to have_content '投稿に成功しました！'
        expect(page).to have_content post.title
      end

      it '投稿を削除することができる' do
        expect(page).to have_content post.title
        within first('.text-content') do
          expect(page).to have_content '削除'
          click_on '削除'
        end
        expect(page).not_to have_content post.title
        expect(page).to have_content '削除が成功しました！'
      end

      it '投稿を編集することができる' do
        expect(page).to have_content post.title
        within first('.text-content') do
          expect(page).to have_content '編集'
          click_on '編集'
        end
        fill_in 'content', with: '最高に面白い'
        click_on '編集する'
        expect(current_path).to eq user_path(user)
        expect(page).to have_content '投稿の編集に成功しました！'
      end
    end

    describe 'new page form', js: true do
      before do
        visit search_path
        fill_in 'keyword', with: '刃牙'
        click_on '漫画を検索'
        within first('.item-search') do
          click_on 'save'
        end
      end

      it 'isbnコードが存在していれば、他フォームも自動入力されていること' do
        expect(current_path).to eq new_post_path
        expect(page).to have_css '#isbn'
        expect(find('#isbn').value).to eq '9784309028439'
        expect(page).to have_field '写真用URL', with: post.image_url
        expect(page).to have_field '漫画タイトル', with: '『グラップラー刃牙』はBLではないかと1日30時間300日考えた乙女の記録ッッ'
        expect(page).to have_field '楽天用URL', with: post.url
        expect(page).to have_field '投稿者様のオススメポイント', with: ''
      end
    end
  end
end
