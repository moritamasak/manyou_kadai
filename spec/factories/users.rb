FactoryBot.define do
  factory :user, class: User do
    name { "user1" }
    email { "user1@gmail.com" }
    password { "user1@gmail.com" }
    password_confirmation { "user1@gmail.com" }
    admin {true}
  end
  factory :second_user, class: User do
    name { "user2" }
    email { "user2@gmail.com" }
    password { "user2@gmail.com" }
    password_confirmation { "user2@gmail.com" }
    admin {false}
  end
end
