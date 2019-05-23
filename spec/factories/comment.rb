FactoryBot.define do
  factory :comment do
    comment_text { 'comment_text' }
    article_id { 1 }
    user_id { 1 }
  end
end
