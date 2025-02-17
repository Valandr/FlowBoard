FactoryBot.define do
  factory :figure do
    name { "MyString" }
    description { "MyText" }
    skill_level { 1 }
    learning_duration { 1 }
    categories { "MyString" }
    video_url { "MyString" }
  end
end
