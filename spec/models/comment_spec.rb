require 'rails_helper'
RSpec.describe Comment, type: :model do
  describe 'データの保存' do
    context '全ての項目を入力しているので保存される' do
      before do
        @user = create(:user)
        @article = create(:article)
        @comment = Comment.new(
          comment_text: 'comment',
          article_id: 1,
          user_id: 1
        )
      end
      it 'データが正しく保存される' do
        expect(@comment.save).to be_truthy
      end
    end
  end

  describe 'バリデーション' do
    context 'comment_textが1文字未満だった場合' do
      before do
        @user = create(:user)
        @article = create(:article)
        @comment = Comment.new(
          comment_text: '',
          article_id: 1,
          user_id: 1
        )
      end
      it 'データは保存されない' do
        expect(@comment.save).to be_falsey
      end
    end

    context 'comment_textが100文字より多い場合' do
      before do
        @user = create(:user)
        @article = create(:article)
        @comment = Comment.new(
          comment_text: 'comment' * 100,
          article_id: 1,
          user_id: 1
        )
      end
      it 'データは保存されない' do
        expect(@comment.save).to be_falsey
      end
    end
  end

  describe '外部キーがない場合' do
    context 'user_idがない場合' do
      before do
        @article = create(:article)
        @comment = Comment.new(
          comment_text: 'comment',
          article_id: 1,
          user_id: 1
        )
      end
      it 'データは保存されない' do
        expect(@comment.save).to be_falsey
      end
    end

    context 'article_idがない場合' do
      before do
        @user = create(:user)
        @comment = Comment.new(
          comment_text: 'comment',
          article_id: 1,
          user_id: 1
        )
      end
      it 'データは保存されない' do
        expect(@comment.save).to be_falsey
      end
    end
  end
end
