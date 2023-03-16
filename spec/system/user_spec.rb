require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do

  describe 'ユーザー登録のテスト' do
    context 'ユーザーが新規作成した場合' do
      it '新規作成したユーザーの内容が詳細画面に表示される' do
        visit new_user_path
        fill_in 'user[name]',with: 'user1'
        fill_in 'user[email]',with: 'user1@gmail.com'
        fill_in 'user[password]',with: 'user01'
        fill_in 'user[password_confirmation]',with: 'user01'
        click_on 'アカウントを作成します'
        expect(page).to have_content 'ユーザー登録しました'
      end
    end
    context 'ログインせずに一覧ページにアクセス' do
      it 'ログイン画面に遷移' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'Password'
      end
    end
  end
  describe 'セッション機能' do
    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'user1@gmail.com'
      fill_in 'session[password]', with: 'user1@gmail.com'
      click_button 'ログイン'
    end
    context 'ログインできるのか' do
      it'ログインできるのか' do
        expect(page).to have_content 'ログインしました'
      end
    end

    context 'マイページ(詳細)を見られるか' do
      it 'マイページ(詳細)にいけるか' do
        visit user_path(user.id)
        expect(page).to have_content 'user1'
      end
    end
    context '一般ユーザが他人の詳細画面に飛んだ場合' do
      it 'タスク一覧画面に遷移して表示される' do
        visit user_path(user.id)
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログアウトした場合' do
      it 'ログイン画面に戻り「ログアウトしました！」が表示される' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理画面機能(管理ユーザ)' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:second_user) {FactoryBot.create(:second_user) }
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'user1@gmail.com'
      fill_in 'session[password]', with: 'user1@gmail.com'
      click_button 'ログイン'
    end
    context '管理ユーザが「管理者画面はこちら」にアクセスした場合' do
      it '管理画面のユーザ一覧が表示される' do  
        visit admin_users_path
        expect(page).to have_content 'user1'
      end

      it 'ユーザの新規登録ができる' do
        visit new_admin_user_path
        fill_in 'user[name]', with: 'user1'
        fill_in 'user[email]', with: 'user3@gmail.com'
        select '管理者ユーザー', from: 'user[admin]'
        fill_in 'user[password]', with: 'user01'
        fill_in 'user[password_confirmation]', with: 'user01'
        click_on '登録する'
      end
      it 'ユーザーの詳細画面にアクセスできる' do
        visit admin_user_path(user.id)
        expect(page).to have_content ''
      end
      it 'ユーザーを編集画面から編集できる' do
        visit edit_admin_user_path(user.id)
        fill_in 'user[name]', with: 'user2'
        click_on '更新する'
        expect(page).to have_content 'user2'
      end
      it'ユーザーを削除することができる' do
        visit admin_users_path
        accept_alert do
          click_on '削除', match: :first
        end
        expect(page).to have_content 'ユーザーを削除しました'
      end
    end
  end
  describe '管理画面機能(一般ユーザ)' do
    context'一般ユーザ' do
      it '管理画面にアクセスできない' do
        user3 = FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session[email]', with: 'user2@gmail.com'
        fill_in 'session[password]', with: 'user2@gmail.com'
        click_button 'ログイン'
        visit admin_users_path
        expect(page).to have_content 'あなたは管理者ではありません'
      end
    end
  end
end