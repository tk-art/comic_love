require 'rails_helper'

RSpec.describe 'Follow, Unfollow', type: :system do
  let(:michael) { create(:user) }
  let(:archer)  { create(:user) }
  let(:lana)    { create(:user) }
  let(:malory)  { create(:user) }

  before do
    sign_in(michael.email, michael.password)
    michael.follow(archer)
    michael.follow(lana)
    archer.follow(michael)
    malory.follow(michael)
  end

  describe 'Feed' do
    let!(:post1) { create(:post, user_id: michael.id) }
    let!(:post2) { create(:post, user_id: archer.id) }
    let!(:post3) { create(:post, user_id: lana.id) }
    let!(:post4) { create(:post, user_id: malory.id) }

    it 'フォローしているユーザーの投稿だけを取ってくる' do
      visit root_path
      expect(page).to have_css '.mli', count: 3
      expect(page).to have_link michael.name
      expect(page).to have_link archer.name
      expect(page).to have_link lana.name
      expect(page).not_to have_link malory.name
    end
  end

  describe 'follow unfollow btn' do
    context '自分以外のプロフィールページ' do
      it 'フォローボタンが表示されている' do
        visit user_path(archer.id)
        expect(page).to have_css '.follow-btn'
      end

      it 'Unfollowボタンをクリックすると、ボタンの表示がFollowに変わり、フォロー人数も一人減る' do
        visit user_path(archer.id)
        expect(page).to have_button 'Unfollow'
        expect(page).to have_content 'フォロワー 1人'
        find('.follow-btn').click
        expect(page).to have_button 'Follow'
        expect(page).to have_content 'フォロワー 0人'
      end

      it 'Followボタンをクリックすると、ボタンの表示がUnfollowに変わり、フォロー人数も一人増える' do
        visit user_path(malory.id)
        expect(page).to have_button 'Follow'
        expect(page).to have_content 'フォロワー 0人'
        find('.follow-btn').click
        expect(page).to have_button 'Unfollow'
        expect(page).to have_content 'フォロワー 1人'
      end
    end

    context '自分自身のプロフィールページ' do
      it 'フォローボタンが表示されていない' do
        visit user_path(michael.id)
        expect(page).not_to have_css '.follow-btn'
      end
    end
  end

  it '名前をふむと、ユーザーのプロフィールページに移動する' do
    visit following_user_path(michael)
    expect(page).to have_content michael.name
    click_on michael.name
    expect(current_path).to eq user_path(michael)
    visit following_user_path(michael)
    click_on archer.name
    expect(current_path).to eq user_path(archer)
  end

  describe 'following page' do
    let(:user) { create_list(:user, 30) }

    it 'following pageでは自分がフォローしているユーザーが表示されている' do
      visit following_user_path(michael)
      expect(page).to have_content 'フォロワー 2人'
      expect(page).to have_content 'フォロー中 2人'
      expect(page).to have_content archer.name
      expect(page).to have_content lana.name
      expect(page).to have_css '.icon2', count: 2
      expect(page).not_to have_content malory.name
    end

    it 'ユーザー数が15以上であればページネーションが動く' do
      user.each do |u|
        michael.follow(u)
      end
      visit following_user_path(michael)
      expect(page).to have_css '.pagination'
      expect(page).to have_css '.icon2', count: 15
    end
  end

  describe 'followers page' do
    it 'followers pageでは自分をフォローしているユーザーが表示されている' do
      visit followers_user_path(michael)
      expect(page).to have_content 'フォロワー 2人'
      expect(page).to have_content 'フォロー中 2人'
      expect(page).to have_content archer.name
      expect(page).to have_content malory.name
      expect(page).to have_css '.icon2', count: 2
      expect(page).not_to have_content lana.name
    end
  end
end
