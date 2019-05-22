require 'rails_helper'
RSpec.describe ArticlesController, type: :controller do
  describe 'ログイン不要なページの表示' do
    context 'showで表示されるページ' do
      before do
        article = create(:article)
        get :show, params: { id: article.id }
      end
      it 'ページが正しく表示できているか' do
        expect(response.status).to eq 200
      end
    end

    context 'article_indexで表示されるページ' do
      before do
        all_aritcles = create(:article)
        get :article_index
      end
      it 'ページが正しく表示できているか' do
        expect(response.status).to eq 200
      end
    end

    context 'skateで表示されるページ' do
      before do
        skate_articles = create(:article)
        skate_browse_ranks = create(:article)
        get :skate
      end
      it 'ページが正しく表示できているか' do
        expect(response.status).to eq 200
      end
    end

    context 'skate_practiceで表示されるページ' do
      before do
        skate_practices = create(:article)
        skate_practice_browse_ranks = create(:article)
        get :skate
      end
      it 'ページが正しく表示できているか' do
        expect(response.status).to eq 200
      end
    end

    context 'hiphopで表示されるページ' do
      before do
        hiphop_articles = create(:article)
        hiphop_browse_ranks = create(:article)
        get :hiphop
      end
      it 'ページが正しく表示できているか' do
        expect(response.status).to eq 200
      end
    end
  end

  describe "管理者のみ閲覧可能なページ" do
    context "newで表示されるページ" do
      before do
        user = create(:admin)
        sign_in user
        article = create(:article)
        get :new
        get :edit, params: { id: article.id }
      end
      it "ページが正しく表示できているか" do
        expect(response.status).to eq 200
      end
    end

    context "管理者以外はリダイレクトされるか" do
      before do
        user = create(:user)
        sign_in user
        article = create(:article)
        get :new
        get :edit, params: { id: article.id }
      end
      it "リダイレクトされているか" do
        expect(response.status).to eq 302
      end
    end
  end
end
