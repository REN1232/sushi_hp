require 'rails_helper'

RSpec.describe HomeController, type: :controller do
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
  describe '店舗ページ' do
    context "店舗ページが正しく表示される" do
      before do
        get :store
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'storeテンプレートで表示されること' do
        expect(response).to render_template :store
      end
    end
  end
  describe 'メニューページ' do
    context "メニューページが正しく表示される" do
      before do
        get :menus
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'menusテンプレートで表示されること' do
        expect(response).to render_template :menus
      end
    end
  end
  describe 'こだわりページ' do
    context "こだわりページが正しく表示される" do
      before do
        get :kodawari
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'kodawariテンプレートで表示されること' do
        expect(response).to render_template :kodawari
      end
    end
  end
end
