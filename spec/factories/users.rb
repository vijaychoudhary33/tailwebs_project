FactoryBot.define do
    factory :user do
      email { "test@example.com" }
      username { "test"}
      password { "password" }
    end
  end
  