require 'rails_helper'
RSpec.describe HomesController, type: :controller do
  describe 'HomesControllerのGETメソッド' do
    context 'ページが正しく表示されるか' do
      before do
        :top
        :about
      end
      it 'ページが正しく表示されるか' do
        expect(response.status).to eq 200
      end
    end
  end
end
