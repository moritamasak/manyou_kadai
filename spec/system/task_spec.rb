require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[name]', with: '万葉課題'
        fill_in 'task[content]', with: 'step2'
        fill_in 'task[deadline]', with: '2023-03-11'
        select '着手中', from: 'task[status]'
        select '高', from: 'task[priority]'
        click_on '登録する'
        expect(page).to have_content ("万葉課題")
        expect(page).to have_content ("step2")
        expect(page).to have_content ("2023-03-11")
        expect(page).to have_content ("着手中")
        expect(page).to have_content ("高")
      end
    end
  end
  describe '一覧表示機能' do
    context '終了期限でソートした場合' do
      it 'タスクが終了期限で降順に並んでいる' do
        Task.create(name: "name1",content: "content1",deadline:"2023-03-12",created_at:Time.zone.now,status: "着手中",priority:"高")
        Task.create(name: "name2",content: "content2",deadline:"2023-03-11",created_at:Time.zone.now,status: "着手中",priority:"高")
        Task.create(name: "name3",content: "content3",deadline:"2023-03-10",created_at:Time.zone.now,status: "着手中",priority:"高")
        visit tasks_path
        click_on "終了期限で並び替える"
        visit tasks_path(sort_expired: "true")
        task_name = all('.index-contents')
        expect(task_name[0]).to have_content "name1"
        expect(task_name[1]).to have_content "name2"
        expect(task_name[2]).to have_content "name3"
      end
    end
  end
  describe "検索機能" do
    context 'タイトルで検索できること' do
      it'該当の内容が表示されること' do 
        Task.create(name: "万葉課題",content: "content1",deadline:"2023-03-12",created_at:Time.zone.now,status: "着手中",priority:"高")
        Task.create(name: "name2",content: "content2",deadline:"2023-03-11",created_at:Time.zone.now,status: "着手中",priority:"高")
        Task.create(name: "万葉課題2",content: "content3",deadline:"2023-03-10",created_at:Time.zone.now,status: "着手中",priority:"高")
        visit tasks_path
        fill_in 'task[name]',with: '万葉'
        click_on '検索'
        expect(page).to have_content '万葉課題'
        expect(page).to have_content '万葉課題2'
      end
    end
    context 'ステータスで検索できること' do
      it'該当の内容が表示されること' do 
        Task.create(name: "name1",content: "content1",deadline:"2023-03-12",created_at:Time.zone.now,status: "着手中",priority:"高")
        Task.create(name: "name2",content: "content2",deadline:"2023-03-11",created_at:Time.zone.now,status: "未着手",priority:"高")
        Task.create(name: "name3",content: "content3",deadline:"2023-03-10",created_at:Time.zone.now,status: "完了",priority:"高")
        visit tasks_path
        select '着手中', from: 'task[status]'
        click_on '検索'
        expect(page).to have_content 'name1'
      end
    end
    context 'タイトルとステータスで検索できること' do
      it'該当の内容が表示されること' do 
        Task.create(name: "name1",content: "content1",deadline:"2023-03-12",created_at:Time.zone.now,status: "着手中",priority:"高")
        Task.create(name: "name2",content: "content2",deadline:"2023-03-11",created_at:Time.zone.now,status: "未着手",priority:"高")
        Task.create(name: "name3",content: "content3",deadline:"2023-03-10",created_at:Time.zone.now,status: "完了",priority:"高")
        visit tasks_path
        fill_in 'task[name]',with: 'name1'
        select '着手中', from: 'task[status]'
        click_on '検索'
        expect(page).to have_content 'name1'
      end
    end
  end
  describe '一覧表示機能' do
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        Task.create(name: "name1",content: "content1",deadline:"2023-03-12",created_at:Time.zone.now,status: "着手中",priority:"高")
        Task.create(name: "name2",content: "content2",deadline:"2023-03-11",created_at:"2023-03-09",status: "着手中",priority:"高")

        visit tasks_path
        task_name = all('.index-contents')
        expect(task_name[0]).to have_content 'name1'
        expect(task_name[1]).to have_content "name2"
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        @task = FactoryBot.create(:task, name: 'task')
        visit task_path(@task)
        expect(page).to have_content ('task')
       end
     end
  end
end