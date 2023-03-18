require 'rails_helper'
RSpec.describe 'ラベル追加機能', type: :system do
  let!(:test_label2) {FactoryBot.create(:test_label2)}
  describe'新規作成機能' do
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'user1@gmail.com'    
      fill_in 'session[password]', with: 'user1@gmail.com'   
      click_button 'ログイン'
    end
    context 'タスクを新規作成場合にラベルをつけることができる' do
      it 'ラベルが作成される' do
        visit new_task_path
        fill_in 'task[name]', with: '万葉課題'
        fill_in 'task[content]', with: '終わらせる'
        fill_in 'task[deadline]', with: '2023-03-11'
        select '着手中', from: 'task[status]'
        select '高', from: 'task[priority]'
        check 'sample2'
        click_on '登録する'
        expect(page).to have_content ("万葉課題")
        expect(page).to have_content ("終わらせる")
        expect(page).to have_content ("2023-03-11")
        expect(page).to have_content ("着手中")
        expect(page).to have_content ("高")
        expect(page).to have_content ("")
      end
    end
  end
  context 'タスク詳細に移行した場合' do
    it "ラベルが表示される" do
      visit new_session_path
      fill_in 'session[email]', with: 'user1@gmail.com'    
      fill_in 'session[password]', with: 'user1@gmail.com'   
      click_button 'ログイン'
      click_on 'タスク一覧画面へ'
      visit new_task_path
      fill_in 'task[name]', with: '万葉課題'
      fill_in 'task[content]', with: '終わらせる'
      fill_in 'task[deadline]', with: '2023-03-11'
      select '着手中', from: 'task[status]'
      select '高', from: 'task[priority]'
      check 'sample2'
      click_on '登録する'
      click_on '登録する'
      # binding.irb
      click_on '詳細'
      expect(page).to have_content 'sample2'
    end
  end
  context 'ラベル検索をした場合' do
    it "タスクが絞り込まれる" do
      visit new_session_path
      fill_in 'session[email]', with: 'user1@gmail.com'    
      fill_in 'session[password]', with: 'user1@gmail.com'   
      click_button 'ログイン'
      click_on 'タスク一覧画面へ'
      visit new_task_path
      fill_in 'task[name]', with: '万葉課題'
      fill_in 'task[content]', with: '終わらせる'
      fill_in 'task[deadline]', with: '2023-03-11'
      select '着手中', from: 'task[status]'
      select '高', from: 'task[priority]'
      check 'sample2'
      click_on '登録する'
      click_on '登録する'
      select 'sample2',from:'task[label_ids]'
      click_button '検索'
      expect(page).to have_content 'sample2'
    end
  end
end
    
