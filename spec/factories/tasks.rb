FactoryBot.define do

  factory :task do
    name {'task_name'}
    content {'test_content'}
    deadline {'2023-03-11'}
    status {'着手中'}
    priority {'高'}
    user_id {'1'}
    label_ids {1}
  end

  factory :second_task,class: Task do
    name {'test_name2'}
    content {'test_content2'}
    deadline {'2023-03-12'}
    status {'未着手'}
    priority {'中'}
    user_id {'1'}
  end

  factory :label_task, class: Task do
    name {'ラベル１'}
    content {'ラベル１'}
    deadline {'2023-03-12'}
    status {'未着手'}
    priority {'中'}
    user_id {'1'}
    label_ids {1}
  end
end