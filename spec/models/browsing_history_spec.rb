require 'rails_helper'
RSpec.describe BrowsingHistory, type: :model do
  describe 'データの保存' do
    context '全ての項目を入力しているので保存される' do
      before do
        @user = create(:user)
        @article = create(:article)
        @browsing_history = BrowsingHistory.new(
          user_id: 1,
          article_id: 1,
          history_genre: 'Skate'
        )
      end
      it 'データが正しく保存される' do
        expect(@browsing_history.save).to be_truthy
      end
    end
  end

  describe 'データが保存されない場合' do
    context 'userがいない場合' do
      before do
        @article = create(:article)
        @browsing_history = BrowsingHistory.new(
          user_id: 1,
          article_id: 1,
          history_genre: 'Skate'
        )
      end
      it 'データが保存されない' do
        expect(@browsing_history.save).to be_falsey
      end
    end

    context 'articleがない場合' do
      before do
        @user = create(:user)
        @browsing_history = BrowsingHistory.new(
          user_id: 1,
          article_id: 1,
          history_genre: 'Skate'
        )
      end
      it 'データが保存されない' do
        expect(@browsing_history.save).to be_falsey
      end
    end
  end
end
