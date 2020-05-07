require 'rails_helper'

RSpec.describe Admin::NoticesController, type: :controller do
  let(:admin) { create(:admin) }
  before do
    sign_in(admin)
  end
  describe 'お知らせ一覧ページ' do
    context "お知らせ一覧ページが正しく表示される" do
      let(:notices) { create_list :notice, 2 }
      before do
        get :index
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'assigns @notices' do
        expect(assigns(:notices)).to match_array notices
      end
      it 'indexテンプレートで表示されること' do
        expect(response).to render_template :index
      end
    end
  end
  describe 'お知らせ登録ページ' do
    context "お知らせ登録ページが正しく表示される" do
      before do
        get :new
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'assigns new @notice' do
        expect(assigns(:notice)).to be_a_new Notice
      end
      it 'newテンプレートで表示されること' do
        expect(response).to render_template :new
      end
    end
  end
  describe 'お知らせアクション（create）' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post :create, params: { notice: FactoryBot.attributes_for(:notice) }
        expect(response.status).to eq 302
      end

      it 'お知らせが登録されること' do
        expect do
          post :create, params: { notice: FactoryBot.attributes_for(:notice) }
        end.to change(Notice, :count).by(1)
      end

      it 'リダイレクトすること' do
        post :create, params: { notice: FactoryBot.attributes_for(:notice) }
        expect(response).to redirect_to (admin_notices_path)
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post :create, params: { notice: FactoryBot.attributes_for(:notice,:invalid) }
        expect(response.status).to eq 200
      end

      it 'お知らせが登録されないこと' do
        expect do
          post :create, params: { notice: FactoryBot.attributes_for(:notice, :invalid) }
        end.to_not change(Notice, :count)
      end

      it 'newテンプレートで表示されること' do
        post :create, params: { notice: FactoryBot.attributes_for(:notice, :invalid) }
        expect(response).to render_template :new
      end

      it 'エラーが表示されること' do
        post :create, params: { notice: FactoryBot.attributes_for(:notice, :invalid) }
        expect(assigns(:notice).errors.any?).to be_truthy
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
      it 'assigns @notice' do
        expect(assigns(:notice)).to eq @notice
      end
      it 'showテンプレートで表示されること' do
        expect(response).to render_template :show
      end
    end
  end
  describe 'お知らせ編集ページ' do
    context "お知らせ編集ページが正しく表示される" do
      before:each do
        @notice = create(:notice)
        get :edit, params: { id: @notice }
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'assigns @notice' do
        expect(assigns(:notice)).to eq @notice
      end
      it 'editテンプレートで表示されること' do
        expect(response).to render_template :edit
      end
    end
  end
  describe 'お知らせアクション（update）' do
    let!(:notice) { create(:notice) }
    let(:update_notices) do
      {
          title: 'update 築地寿司',
      }
    end

    it 'リクエストが成功すること' do
      expect do
        patch :update, params: { id: notice.id, notice: update_notices }, session: {}
      end.to change(Notice, :count).by(0)
    end

    it 'タイトルが更新されること' do
      patch :update, params: { id: notice.id, notice: update_notices }, session: {}
      notice.reload
      expect(notice.title).to eq update_notices[:title]
    end

    it 'リダイレクトすること' do
      patch :update, params: { id: notice.id, notice: update_notices }, session: {}
      notice = Notice.last
      expect(response).to redirect_to(admin_notice_path(notice))
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        put :update, params: { id: notice.id, notice: FactoryBot.attributes_for(:notice,:invalid) }
        expect(response.status).to eq 200
      end

      it 'タイトルが変更されないこと' do
        expect do
        put :update, params: { id: notice.id, notice: FactoryBot.attributes_for(:notice,:invalid) }
        end.to_not change(Notice.find(notice.id), :title)
      end

      it 'editテンプレートで表示されること' do
        put :update, params: { id: notice.id, notice: FactoryBot.attributes_for(:notice,:invalid) }
        expect(response).to render_template :edit
      end

      it 'エラーが表示されること' do
        put :update, params: { id: notice.id, notice: FactoryBot.attributes_for(:notice, :invalid) }
        expect(assigns(:notice).errors.any?).to be_truthy
      end
    end
  end
  describe 'お知らせアクション（destroy）' do
    let!(:notice) { FactoryBot.create :notice }

    it 'リクエストが成功すること' do
      delete :destroy, params: { id: notice }
      expect(response.status).to eq 302
    end

    it 'お知らせが削除されること' do
      expect do
        delete :destroy, params: { id: notice }
      end.to change(Notice, :count).by(-1)
    end

    it 'お知らせ一覧にリダイレクトすること' do
      delete :destroy, params: { id: notice }
      expect(response).to redirect_to(admin_notices_path)
    end
  end
end