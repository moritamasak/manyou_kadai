FactoryBot.define do
  factory :task do
    name { 'test_name'}
    content { 'test_content'}
    deadline {'2023-03-11'}
    status {'未着手'}
    priority {'高'}
  end
  factory :second_task do
    name { 'test_name2'}
    content { 'test_content2'}
    deadline {'2023-03-12'}
    status {'着手中'}
    priority {'中'}
  end
  
end