FactoryBot.define do
  factory :user do
    id { 1 }
    name { "sample" }
    email { "sample@aaa.com" }
    password { "0000000" }
    admin { false }
  end
  factory :admin_user, class: User do
    id { 2 }
    name { "admin_user" }
    email { "admine@aaa.com" }
    password { "0000000" }
    admin { true }
  end
  factory :second_admin_user, class: User do
    id { 3 }
    name { "second_admin_user" }
    email { "second_admin@aaa.com" }
    password { "0000000" }
    admin { true }
  end
end
