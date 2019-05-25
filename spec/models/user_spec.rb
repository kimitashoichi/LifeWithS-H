require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'データの保存' do
    context 'user_image以外の項目を入力しているので保存される' do
      before do
        @user = create(:user)
      end
      it 'データが正しく保存される' do
        expect(@user.save).to be_truthy
      end
    end
  end

  describe 'バリデーション' do
    context 'last_nameが空白の場合' do
      before do
        @user = build(:user, last_name: "")
      end
      it 'データは保存されない' do
        expect(@user.save).to be_falsey
      end
    end

    context 'first_nameが空白の場合' do
      before do
        @user = build(:user, first_name: "")
      end
      it 'データは保存されない' do
        expect(@user.save).to be_falsey
      end
    end

    context 'emailが空白の場合' do
      before do
        @user = build(:user, email: "")
      end
      it 'データは保存されない' do
        expect(@user.save).to be_falsey
      end
    end

    context 'emailが重複した場合' do
      before do
        @user = create(:user)
        @another_user = create(:another_user)
      end
      it 'データは正しく保存される' do
        expect(@user.save).to be_truthy
      end
      it 'emailが重複しているので保存されない' do
        expect(FactoryBot.build(:another_user, email: @user.email).save).to be_falsey
      end
    end

    context 'パスワードが空白の場合' do
      before do
        @user = FactoryBot.build(:user, password: "")
      end
      it 'データは保存されない' do
        expect(@user.save).to be_falsey
      end
    end

    context '確認用パスワードとパスワードが異なる場合' do
      before do
        @user = create(:user)
      end
      it 'データは保存されない' do
        expect(FactoryBot.build(:user, password: 'another_password').save).to be_falsey
      end
    end
  end

  describe 'ユーザーモデルのアソシエーション' do
    context 'ユーザーが削除された場合' do
      before do
        @user = create(:user)
        @article = create(:article)
        @user.comments.create(comment_text: 'comment_text', article_id: 1, user_id: 1)
      end
      it 'コメントも同時に削除される' do
        expect { @user.destroy }.to change { Comment.count }.by(-1)
      end

      it '返信も同時に削除される' do
        @user.replies.create(reply_text: 'reply_text', comment_id: 1, user_id: 1)
        expect { @user.destroy }.to change { Reply.count }.by(-1)
      end

      it 'お問い合わせも同時に削除される' do
        @user.contacts.create(contact_title: 'contact_title',
                              contact_text: 'comment_text_text',
                              contact_email: 'comment_email@test.com',
                              contact_name: 'test_user',
                              user_id: 1)
        expect { @user.destroy }.to change { Contact.count }.by(-1)
      end

      it '閲覧履歴も同時に削除される' do
        @user.browsing_histories.create(user_id: 1, article_id: 1, history_genre: 'Skate')
        expect { @user.destroy }.to change { BrowsingHistory.count }.by(-1)
      end

      it 'お気に入りも同時に削除される' do
        @user.favorites.create(user_id: 1, article_id: 1)
        expect { @user.destroy }.to change { Favorite.count }.by(-1)
      end
    end
  end
end
