require 'rails_helper'
RSpec.describe Article, type: :model do
  describe 'データの保存' do
    context '全ての項目を入力しているので保存される' do
      before do
        @article = Article.new(
          movie_url: "https://www.youtube.com/watch?v=dTyT-nNPL8g&t=3670s",
          article_url: "https://qiita.com/imotan/items/c73fab5ee230114a08b6",
          article_title: "article_title_title",
          article_text: "article_text_text_text_text_text_text_text_text_text_text_text_text_text",
          genre: "Skate",
          link_name: "testlinkname"
        )
      end
      it 'データが正しく保存される' do
        expect(@article.save).to be_truthy
      end
    end
  end

  describe 'バリデーション' do
    context 'タイトルが10文字以下の場合' do
      before do
        @article = Article.new(
          movie_url: "https://www.youtube.com/watch?v=dTyT-nNPL8g&t=3670s",
          article_url: "https://qiita.com/imotan/items/c73fab5ee230114a08b6",
          article_title: "title",
          article_text: "article_text" * 10,
          genre: "Skate",
          link_name: "testlinkname"
        )
      end
      it 'データは保存されない' do
        expect(@article.save).to be_falsey
      end
    end

    context 'タイトルが35文字以上の場合' do
      before do
        @article = Article.new(
          movie_url: "https://www.youtube.com/watch?v=dTyT-nNPL8g&t=3670s",
          article_url: "https://qiita.com/imotan/items/c73fab5ee230114a08b6",
          article_title: "article_title" * 7,
          article_text: "article_text_text_text_text_text_text_text_text_text_text_text_text_text",
          genre: "Skate",
          link_name: "testlinkname"
        )
      end
      it 'データは保存されない' do
        expect(@article.save).to be_falsey
      end
    end

    context 'テキストが50文字以下の場合' do
      before do
        @article = Article.new(
          movie_url: "https://www.youtube.com/watch?v=dTyT-nNPL8g&t=3670s",
          article_url: "https://qiita.com/imotan/items/c73fab5ee230114a08b6",
          article_title: "article_title_title",
          article_text: "article_text",
          genre: "Skate",
          link_name: "testlinkname"
        )
      end
      it 'データは保存されない' do
        expect(@article.save).to be_falsey
      end
    end

    context 'テキストが700文字以上の場合' do
      before do
        @article = Article.new(
          movie_url: "https://www.youtube.com/watch?v=dTyT-nNPL8g&t=3670s",
          article_url: "https://qiita.com/imotan/items/c73fab5ee230114a08b6",
          article_title: "article_title_title",
          article_text: "article" * 99999,
          genre: "Skate",
          link_name: "testlinkname"
        )
      end
      it 'データは保存されない' do
        expect(@article.save).to be_falsey
      end
    end

    context 'ジャンルが空白だった場合' do
      before do
        @article = Article.new(
          movie_url: "https://www.youtube.com/watch?v=dTyT-nNPL8g&t=3670s",
          article_url: "https://qiita.com/imotan/items/c73fab5ee230114a08b6",
          article_title: "article_title_title",
          article_text: "article" * 20,
          genre: "",
          link_name: "testlinkname"
        )
      end
      it 'データは保存されない' do
        expect(@article.save).to be_falsey
      end
    end

    context 'リンク名が空白だった場合' do
      before do
        @article = Article.new(
          movie_url: "https://www.youtube.com/watch?v=dTyT-nNPL8g&t=3670s",
          article_url: "https://qiita.com/imotan/items/c73fab5ee230114a08b6",
          article_title: "article_title_title",
          article_text: "article" * 20,
          genre: "Skate",
          link_name: ""
        )
      end
      it 'データは保存されない' do
        expect(@article.save).to be_falsey
      end
    end

    context '動画URLが空白だった場合' do
      before do
        @article = Article.new(
          movie_url: "",
          article_url: "https://qiita.com/imotan/items/c73fab5ee230114a08b6",
          article_title: "article_title_title",
          article_text: "article" * 20,
          genre: "Skate",
          link_name: "test_link_name"
        )
      end
      it 'データは保存されない' do
        expect(@article.save).to be_falsey
      end
    end

    context 'リンクURLが空白だった場合' do
      before do
        @article = Article.new(
          movie_url: "https://www.youtube.com/watch?v=dTyT-nNPL8g&t=3670s",
          article_url: "",
          article_title: "article_title_title",
          article_text: "article" * 20,
          genre: "Skate",
          link_name: "test_link_name"
        )
      end
      it 'データは保存されない' do
        expect(@article.save).to be_falsey
      end
    end
  end

  describe 'アーティクルモデルのアソシエーション' do
    context 'アーティクルが削除された場合' do
      before do
        @user = create(:user)
        @article = create(:article)
      end
      it 'お気に入りも同時に削除される' do
        @user.favorites.create(user_id: 1, article_id: 1)
        expect { @article.destroy }.to change { Favorite.count }.by(-1)
      end

      it 'コメントも同時に削除される' do
        @user.comments.create(comment_text: 'comment_text', article_id: 1, user_id: 1)
        expect { @article.destroy }.to change { Comment.count }.by(-1)
      end

      it '画像も同時に削除される' do
        @article.article_images.create(article_id: 1, image_id: '7af73dd7e1f06c92b83a')
        expect { @article.destroy }.to change { ArticleImage.count }.by(-1)
      end

      it '閲覧履歴も同時に削除される' do
        @user.browsing_histories.create(user_id: 1, article_id: 1, history_genre: 'Skate')
        expect { @article.destroy }.to change { BrowsingHistory.count }.by(-1)
      end
    end
  end
end
