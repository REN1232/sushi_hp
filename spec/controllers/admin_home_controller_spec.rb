require 'rails_helper'

RSpec.describe Admin::HomeController, type: :controller do
  let(:admin) { create(:admin) }
  before do
    sign_in(admin)
  end
  describe 'アバウトページ' do
    context "アバウトページが正しく表示される" do
      before do
        get :about
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'aboutテンプレートで表示されること' do
        expect(response).to render_template :about
      end
    end
  end
end