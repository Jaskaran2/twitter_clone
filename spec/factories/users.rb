FactoryBot.define do
  factory :user do
    name {"Test"}
    sequence(:username) {|n| "Tester#{n}"}
    sequence(:email) {|n| "test#{n}@gmail.com"}    
    password {"123456"}
    password_confirmation {"123456"}

   
  end
end
