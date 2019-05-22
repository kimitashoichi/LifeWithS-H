FactoryBot.define do
  factory :article do
    movie_url { "https://www.youtube.com/watch?v=dTyT-nNPL8g&t=3670s" }
    article_url { "https://qiita.com/imotan/items/c73fab5ee230114a08b6" }
    article_title { "article_title_title" }
    article_text { "article_text_text_text_text_text_text_text_text_text_text_text_text_text" }
    genre { "Skate" }
    link_name { "testlinkname" }
  end
end
