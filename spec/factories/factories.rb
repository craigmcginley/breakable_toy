include ActionDispatch::TestProcess

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
    event_date "01/01/2000"
    factory :post_with_family do
      after(:build) do |post|
        post.families << FactoryGirl.create(:family)
      end
    end
  end

  factory :post_image do
    post
    url { fixture_file_upload (File.join(Rails.root, '/spec/fixtures/images/post_photo.jpg')) }
  end

  factory :post_video do
    post
    url "5NV6Rdv1a3I"
  end

  factory :comment do
    body "Awesome post! Radical!"
    post
    user
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
