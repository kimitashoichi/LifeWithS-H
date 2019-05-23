require 'rails_helper'
RSpec.describe Contact, type: :model do
  describe 'データの保存' do
    context '全ての項目を入力しているので保存される' do
      before do
        @user = create(:user)
        @contact = Contact.new(
          contact_title: 'contact_title',
          contact_text: 'contact_text' * 2,
          contact_email: 'contact_email@test.com',
          user_id: 1,
          contact_name: 'test_user'
        )
      end
      it 'データが正しく保存される' do
        expect(@contact.save).to be_truthy
      end
    end
  end

  describe 'バリデーション' do
    context 'contact_nameが空白だった場合' do
      before do
        @user = create(:user)
        @contact = Contact.new(
          contact_title: 'contact_title',
          contact_text: 'contact_text' * 2,
          contact_email: 'contact_email@test.com',
          user_id: 1,
          contact_name: ''
        )
      end
      it 'データは保存されない' do
        expect(@contact.save).to be_falsey
      end
    end

    context 'contact_emailが空白だった場合' do
      before do
        @user = create(:user)
        @contact = Contact.new(
          contact_title: 'contact_title',
          contact_text: 'contact_text' * 2,
          contact_email: '',
          user_id: 1,
          contact_name: 'test_user'
        )
      end
      it 'データは保存されない' do
        expect(@contact.save).to be_falsey
      end
    end

    context 'contact_titleが1文字未満だった場合' do
      before do
        @user = create(:user)
        @contact = Contact.new(
          contact_title: '',
          contact_text: 'contact_text' * 2,
          contact_email: 'contact_email@test.com',
          user_id: 1,
          contact_name: 'test_user'
        )
      end
      it 'データは保存されない' do
        expect(@contact.save).to be_falsey
      end
    end

    context 'contact_titleが30文字より多い場合' do
      before do
        @user = create(:user)
        @contact = Contact.new(
          contact_title: 'contact_title' * 100,
          contact_text: 'contact_text',
          contact_email: 'contact_email@test.com',
          user_id: 1,
          contact_name: 'test_user'
        )
      end
      it 'データは保存されない' do
        expect(@contact.save).to be_falsey
      end
    end

    context 'contact_textが1文字未満だった場合' do
      before do
        @user = create(:user)
        @contact = Contact.new(
          contact_title: 'contact_title',
          contact_text: '',
          contact_email: 'contact_email@test.com',
          user_id: 1,
          contact_name: 'test_user'
        )
      end
      it 'データは保存されない' do
        expect(@contact.save).to be_falsey
      end
    end

    context 'contact_textが200文字より多い場合' do
      before do
        @user = create(:user)
        @contact = Contact.new(
          contact_title: 'contact_title',
          contact_text: 'contact_text' * 100,
          contact_email: 'contact_email@test.com',
          user_id: 1,
          contact_name: 'test_user'
        )
      end
      it 'データは保存されない' do
        expect(@contact.save).to be_falsey
      end
    end
  end

  describe '外部キーがない場合' do
    context 'user_idがない場合' do
      before do
        @contact = Contact.new(
          contact_title: 'contact_title',
          contact_text: 'contact_text' * 100,
          contact_email: 'contact_email@test.com',
          user_id: 1,
          contact_name: 'test_user'
        )
      end
      it 'データは保存されない' do
        expect(@contact.save).to be_falsey
      end
    end
  end
end
