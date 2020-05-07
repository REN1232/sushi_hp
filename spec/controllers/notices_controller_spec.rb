require 'rails_helper'

RSpec.describe NoticesController, type: :controller do
  describe 'お知らせ一覧ページ' do
    context "お知らせ一覧ページが正しく表示される" do
      let(:notices) { create_list :notice, 2 }
      before do
        get :index
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'assigns index @notices' do
        expect(assigns(:notices)).to match_array notices
      end
      it 'indexテンプレートで表示されること' do
        expect(response).to render_template :index
      end
    end
  end
  describe 'お知らせ詳細ページ' do
    context "お知らせ詳細ページが正しく表示される" do
      before:each do
        @notice = create(:notice)
        get :show, params: { id: @notice }
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'assigns show @notice' do
        expect(assigns(:notice)).to eq @notice
      end
      it 'showテンプレートで表示されること' do
        expect(response).to render_template :show
      end
    end
  end
end
