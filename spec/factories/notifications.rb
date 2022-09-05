FactoryBot.define do
    factory :notification do
        recipient
        actor
        action {nil}

        trait :for_user do
            association :notifiable,factory: :user
        end

        trait :for_tweet do
            association :notifiable,factory: :tweet
        end
        
    end
end