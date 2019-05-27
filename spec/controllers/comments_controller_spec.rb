require 'rails_helper'
RSpec.describe CommentsController, type: :controller do
  describe 'データが投稿できているかどうか' do
    context '全ての項目を入力した場合' do
      before do
        @article = FactoryBot.create(:new_article)
        @user = FactoryBot.create(:user)
        sign_in @user
      end
    end
    binding.pry
    it 'データは正しく保存される' do
      expect {
        post :create, params: { article_id: @article.id { attributes_for(:new_comment) } }
      }.to change { Comment.count }.by(1)
    end
  end
end
