FactoryBot.define do
  factory :user do
    first_name { "Sean" }
    last_name { "Pablo" }
    sequence(:email) { |n| "johney#{n}@test.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :another_user, class: User do
    first_name { "Ben" }
    last_name { "Cadou" }
    sequence(:email) { |n| "Ben#{n}@test.com" }
    password { "another_password" }
    password_confirmation { "another_password" }
  end

  factory :admin, class: User do
    first_name { "Jason" }
    last_name { "Dill" }
    sequence(:email) { |n| "jason#{n}@admin.com" }
    admin { true }
    password { "admin_password" }
    password_confirmation { "admin_password" }
  end
end
