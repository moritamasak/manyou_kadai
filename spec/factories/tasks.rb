FactoryBot.define do
  factory :task do
    name { 'test_name'}
    content { 'test_content'}
    deadline {'2023-03-11'}
    status {'未着手'}
    priority {'高'}
  end
end