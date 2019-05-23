require 'rails_helper'
RSpec.describe ArticleImage, type: :model do
  describe 'データの保存' do
    context '全ての項目を入力しているので保存される' do
      before do
        @article = create(:article)
        @image = @article.article_images.build(
          image_id: '7af73dd7e1f06c92b83a4f88d5cc2636705486985a887664dc444f940ea3',
        )
      end
      it 'データが正しく保存される' do
        expect(@image.save).to be_truthy
      end
    end
  end

  describe 'バリデーション' do
    context 'imegeが無い場合' do
      before do
        @article = create(:article)
        @image = @article.article_images.build(
          image_id: '',
        )
      end
      it 'データは保存されない' do
        expect(@image.save).to be_falsey
      end
    end
  end
end
