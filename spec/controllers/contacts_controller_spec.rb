require 'rails_helper'
RSpec.describe ContactsController, type: :controller do
  describe 'ContactsControllerのGETメソッドの表示' do
    describe '全てのユーザーがアクセスできるページ' do
      context 'ログイン不要なページ' do
        before do
          contacts = create(:contact)
          get :new
        end
        it 'ページが正しく表示されているかどうか' do
          expect(response.status).to eq 200
        end
      end
    end

    describe 'ログインしているユーザーがアクセスできるページ' do
      context 'ログインユーザーが閲覧可能なページ' do
        before do
          user = create(:user)
          sign_in user
          users_contacts = create(:contact)
          get :user_contact_list, params: { id: user.id }
        end
        it 'ページが正しく表示されているかどうか' do
          expect(response.status).to eq 200
        end
      end

      context 'ログインユーザーが閲覧可能なページ' do
        before do
          user = create(:user)
          sign_in user
          contact = create(:contact)
          get :show, params: { id: user.id }
        end
        it 'ページが正しく表示されているかどうか' do
          expect(response.status).to eq 200
        end
      end

      context 'ログインしていないユーザーがリダイレクトされているか' do
        before do
          current_user = create(:user)
          users_contacts = create(:un_sign_in_contact)
          get :user_contact_list, params: { id: current_user.id }
        end
        it "リダイレクトされているかどうか" do
          expect(response.status).to eq 302
        end
      end

      context 'ログインしていないユーザーがリダイレクトされているか' do
        before do
          user = create(:user)
          contact = create(:contact)
          get :show, params: { id: user.id }
        end
        it "リダイレクトされているかどうか" do
          expect(response.status).to eq 302
        end
      end
    end

    describe '管理者権限を持つユーザーがアクセスできるページ' do
      context '管理者のみ閲覧可能なページ' do
        before do
          user = create(:admin)
          current_user = create(:admin)
          sign_in current_user
          contacts = create(:contact)
          get :index, params: { id: user.id }
        end
        it 'ページが正しく表示されているかどうか' do
          expect(response.status).to eq 200
        end
      end

      context '管理者であれば閲覧可能なページ' do
        before do
          user = create(:admin)
          current_user = create(:admin)
          sign_in current_user
          contacts = create(:contact)
          get :user_contact_list, params: { id: user.id }
        end
        it 'ページが正しく表示されているかどうか' do
          expect(response.status).to eq 200
        end
      end

      context '管理者であれば閲覧可能なページ' do
        before do
          user = create(:user)
          current_user = create(:admin)
          sign_in current_user
          contact = create(:contact)
          get :show, params: { id: user.id }
        end
        it 'ページが正しく表示されているかどうか' do
          expect(response.status).to eq 200
        end
      end

      context "管理者権限を持たないユーザーがアクセスした時" do
        before do
          user = create(:user)
          another_user = create(:another_user)
          sign_in user
          contacts = create(:contact)
          get :user_contact_list, params: { id: another_user.id }
        end
        it 'リダイレクトされているかどうか' do
          expect(response.status).to eq 302
        end
      end

      context '管理者権限を持たないユーザーがアクセスした時' do
        before do
          user = create(:user)
          another_user = create(:another_user)
          sign_in user
          contact = create(:contact)
          get :show, params: { id: another_user.id }
        end
        it 'リダイレクトされているかどうか' do
          expect(response.status).to eq 302
        end
      end
    end
  end

  describe 'データが投稿できているかどうか' do
    context '全ての項目を入力した場合' do
      before do
        @user = create(:user)
        sign_in @user
      end
    end
    it 'データは正しく保存される' do
      expect {
        post :create, params: { contact: attributes_for(:contact) }
      }.to change { Contact.count }.by(1)
    end
  end

  describe 'データが削除できるかどうか' do
    context 'destroyアクションが呼ばれた時' do
      before do
        @user = create(:user)
        sign_in @user
        @contact = create(:contact)
      end
      it 'データが削除される' do
        expect {
          delete :destroy, params: { id: @user.id }
        }.to change { Contact.count }.by(-1)
      end
    end

    context '管理者の場合' do
      before do
        @user = create(:admin)
        sign_in @user
        @contact = create(:contact)
      end
      it 'データが削除される' do
        expect {
          delete :destroy, params: { id: @user.id }
        }.to change { Contact.count }.by(-1)
      end
    end
  end
end
