require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  describe 'ページの表示ができているかどうか' do
    describe 'ログインしていない場合' do
      context 'idが不要なページ' do
        before do
          get :index
        end
        it 'リダイレクトされているか' do
          expect(response.status).to eq 302
        end
      end

      context 'idが必要なページ' do
        before do
          user = create(:user)
          get :show, params: { id: user.id }
          get :edit, params: { id: user.id }
          get :favorites, params: { id: user.id }
          get :histroy, params: { id: user.id }
          get :leave, params: { id: user.id }
        end
        it 'リダイレクトされているか' do
          expect(response.status).to eq 302
        end
      end
    end

    describe 'ログインしている場合' do
      context '管理者のみアクセスできるページ' do
        before do
          user = create(:user)
          current_user = create(:admin)
          sign_in user
          get :index, params: { id: current_user.id }
        end
        it 'リダイレクトされているか' do
          expect(response.status).to eq 302
        end
      end

      context 'ログイン後のユーザーがアクセス可能' do
        before do
          user = create(:user)
          sign_in user
          get :show, params: { id: user.id }
          get :edit, params: { id: user.id }
          get :favorites, params: { id: user.id }
          get :histroy, params: { id: user.id }
          get :leave, params: { id: user.id }
        end
        it 'ページが正しく表示されるか' do
          expect(response.status).to eq 200
        end
      end
    end

    describe "管理者権限を使用してページを表示できているかどうか" do
      context "管理者のみアクセスできるページ" do
        before do
          user = create(:user)
          current_user = create(:admin)
          sign_in user
          get :index, params: { id: user.id }
        end
        it "ページが正しく表示されるか" do
          expect(response.status).to eq 200
        end
      end

      context "管理者権限によってページを表示できるかどうか" do
        before do
          user = create(:user)
          current_user = create(:admin)
          sign_in user
          get :edit, params: { id: user.id }
          get :show, params: { id: user.id }
        end
        it "ページが正しく表示されるか" do
          expect(response.status).to eq 200
        end
      end
    end
  end
end
