require 'rails_helper'

describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, name: 'task',status:'未着手') }
    let!(:second_task) { FactoryBot.create(:second_task, name: 'sample',status:'完了') }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it '検索キーワードを含むタスクが絞り込まれる'do 
        expect(Task.name_search('task')).to include(task)
        expect(Task.name_search('task')).not_to include(second_task)
        expect(Task.name_search('task').count).to eq 1
      end
    end
    context'scopeメソッドでステータスを検索した場合' do
      it 'ステータス検索ができる' do
        expect(Task.status_search('未着手')).to include(task)
        expect(Task.status_search('未着手')).not_to include(second_task)
        expect(Task.status_search('未着手').count).to eq 1
      end
    end
    context'scopeメソッドで、タイトルとステータスの検索をした場合' do
      it '検索キーワードを含むタスクとステータス検索ができる' do
        expect(Task.name_search('task') && Task.status_search('未着手')).to include(task)
        expect(Task.name_search('task') && Task.status_search('未着手')).not_to include(second_task)
        expect(Task.name_search('task') && Task.status_search('未着手').count).to eq 1
      end
    end
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