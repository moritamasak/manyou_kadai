require 'rails_helper'

RSpec.describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
      let!(:task) { FactoryBot.create(:task, name: 'task') }
      let!(:second_task) { FactoryBot.create(:second_task, name: "sample") }
      context 'scopeメソッドでタイトルのあいまい検索をした場合' do
        it '検索キーワードを含むタスクが絞り込まれる'do 
          expect(Task.name_search('task')).to include(task)
          expect(Task.name_search('task')).not_to include(second_task)
          expect(Task.name_search('task').count).to eq 1
        end
      end
      # context 'タスクの詳細が空の場合' do
      #   it 'バリデーションにひっかる'  do
      #     task = Task.new(name:'失敗テスト',content:'')
      #     expect(task).not_to be_valid
      #   end
      # end
      # context 'タスクのタイトルと詳細に内容が記載されている場合' do
      #   it 'バリデーションが通る' do
      #     task = Task.new(name:'成功テスト',content:'成功テスト')
      #     expect(task).to be_valid
      #   end
      # end
  end
end