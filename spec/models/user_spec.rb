require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'データの保存' do
    context 'user_image以外の項目を入力しているので保存される' do
      before do
        @user = create(:user)
      end
      it 'データが正しく保存される' do
        expect(@user.save).to be_truthy
      end
    end
  end

  describe 'バリデーション' do
    context 'last_nameが空白の場合' do
      before do
        @user = build(:user, last_name: "")
      end
      it 'データは保存されない' do
        expect(@user.save).to be_falsey
      end
    end

    context 'first_nameが空白の場合' do
      before do
        @user = build(:user, first_name: "")
      end
      it 'データは保存されない' do
        expect(@user.save).to be_falsey
      end
    end

    context 'emailが空白の場合' do
      before do
        @user = build(:user, email: "")
      end
      it 'データは保存されない' do
        expect(@user.save).to be_falsey
      end
    end

    context 'emailが重複した場合' do
      before do
        @user = create(:user)
        @another_user = create(:another_user)
      end
      it 'データは正しく保存される' do
        expect(@user.save).to be_truthy
      end
      it 'emailが重複しているので保存されない' do
        expect(FactoryBot.build(:another_user, email: @user.email).save).to be_falsey
      end
    end

    context 'パスワードが空白の場合' do
      before do
        @user = FactoryBot.build(:user, password: "")
      end
      it 'データは保存されない' do
        expect(@user.save).to be_falsey
      end
    end

    context '確認用パスワードとパスワードが異なる場合' do
      before do
        @user = create(:user)
      end
      it 'データは保存されない' do
        expect(FactoryBot.build(:user, password: 'another_password').save).to be_falsey
      end
    end

    # context 'パスワードが暗号化されているか' do
    #   before do
    #     @user = create(:user)
    #   end
    #   it 'パスワードが暗号化されているか' do
    #     expect(@user.password_digest).to_not eq "password"
    #   end
    # end
  end
end
















