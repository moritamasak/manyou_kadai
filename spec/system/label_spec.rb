require 'rails_helper'
RSpec.describe 'ラベル追加機能', type: :system do

  describe'新規作成機能' do
    context 'タスクを新規作成場合にラベルをつけることができる' do
      it 'ラベルが表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'user1@gmail.com'    
        fill_in 'session[password]', with: 'user1@gmail.com'   
        click_button 'ログイン'
        visit new_task_path
        fill_in 'task[name]', with: '万葉課題'
        fill_in 'task[content]', with: '終わらせる'
        fill_in 'task[deadline]', with: '2023-03-11'
        select '着手中', from: 'task[status]'
        select '高', from: 'task[priority]'
        check 'ラベル１'
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
end
    # describe '新規作成機能' do
    #   context 'ラベルを含むタスクを新規作成した場合' do
    #     it '設定したラベルが詳細画面に存在する' do
    #       visit tasks_path
    #       click_on '詳細'
    #       expect(page).to have_content 'ラベル１'
    #     end
    #   end
