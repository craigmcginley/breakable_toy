FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    sequence(:email) { |i| "jd#{i}@example.com" }
    password "password123"
  end

  factory :post do
    user
    sequence(:title) { |i| "Family Update #{i}"}
    body "Hey everyone! Just wanted to send along an update for this event. Check out this picture!"

    factory :post_with_family do
      after(:build) do |post|
        post.families << FactoryGirl.create(:family)
      end
    end
  end

  factory :family do
    sequence(:surname) { |i| "Family#{i}"}
  end

  factory :family_post do
    family
    post
  end

  factory :family_member do
    family
    user
    role "member"
  end

  factory :invitee do
    sequence(:name) { |i| "Joe#{i}" }
    sequence(:email) { |i| "joe#{i}@example.com" }
  end

end
