require 'rails_helper'

RSpec.describe HomeController, type: :controller do
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
  describe 'トップページ' do
    context "トップページが正しく表示される" do
      before:each do
        get :top
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'assigns top @notices' do
        expect(assigns(:home)).to eq @notices
      end
      it 'topテンプレートで表示されること' do
        expect(response).to render_template :top
      end
    end
  end
end
