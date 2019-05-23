require 'rails_helper'
RSpec.describe Favorite, type: :model do
  describe 'データの保存' do
    context '全ての項目を入力しているので保存される' do
      before do
        @user = create(:user)
        @article = create(:article)
        @favorite = Favorite.new(
          user_id: 1,
          article_id: 1
        )
      end
      it 'データが正しく保存される' do
        expect(@favorite.save).to be_truthy
      end
    end
  end

  describe '外部キーがない場合' do
    context 'user_idがない場合' do
      before do
        @article = create(:article)
        @favorite = Favorite.new(
          user_id: 1,
          article_id: 1
        )
      end
      it 'データは保存されない' do
        expect(@favorite.save).to be_falsey
      end
    end

    context 'article_idがない場合' do
      before do
        @user = create(:user)
        @favorite = Favorite.new(
          user_id: 1,
          article_id: 1
        )
      end
      it 'データは保存されない' do
        expect(@favorite.save).to be_falsey
      end
    end
  end
end
