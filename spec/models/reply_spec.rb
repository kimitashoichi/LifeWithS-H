require 'rails_helper'
RSpec.describe Reply, type: :model do
  describe 'データの保存' do
    context '全ての項目を入力しているので保存される' do
      before do
        @user = create(:user)
        @article = create(:article)
        @comment = create(:comment)
        @reply = Reply.new(
          reply_text: 'reply_text',
          comment_id: 1,
          user_id: 1
        )
      end
      it 'データが正しく保存される' do
        expect(@reply.save).to be_truthy
      end
    end
  end

  describe 'バリデーション' do
    context 'reply_textが1文字未満の場合' do
      before do
        @user = create(:user)
        @article = create(:article)
        @comment = create(:comment)
        @reply = Reply.new(
          reply_text: '',
          comment_id: 1,
          user_id: 1
        )
      end
      it 'データは保存されない' do
        expect(@reply.save).to be_falsey
      end
    end

    context 'reply_textが100文字より多いの場合' do
      before do
        @user = create(:user)
        @article = create(:article)
        @comment = create(:comment)
        @reply = Reply.new(
          reply_text: 'reply_text' * 1000,
          comment_id: 1,
          user_id: 1
        )
      end
      it 'データは保存されない' do
        expect(@reply.save).to be_falsey
      end
    end
  end

  describe '外部キーがない場合' do
    context 'user_idがない場合' do
      before do
        @user = create(:user)
        @article = create(:article)
        @comment = create(:comment)
        @reply = Reply.new(
          reply_text: 'reply_text',
          comment_id: 1,
          user_id: ''
        )
      end
      it 'データは保存されない' do
        expect(@reply.save).to be_falsey
      end
    end

    context 'comment_idがない場合' do
      before do
        @user = create(:user)
        @article = create(:article)
        @reply = Reply.new(
          reply_text: 'reply_text',
          comment_id: 1,
          user_id: 1
        )
      end
      it 'データは保存されない' do
        expect(@reply.save).to be_falsey
      end
    end
  end
end
