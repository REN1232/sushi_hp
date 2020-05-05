require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  describe '予約登録ページ' do
    context "予約登録ページが正しく表示される" do
      before do
        get :new
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'assigns new @reservation' do
        expect(assigns(:reservation)).to be_a_new Reservation
      end
      it 'newテンプレートで表示されること' do
        expect(response).to render_template :new
      end
    end
  end
  describe '予約詳細ページ' do
    context "予約詳細ページが正しく表示される" do
      before:each do
        @reservation = create(:reservation)
        get :show, params: { id: @reservation }
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'assigns @reservation' do
        expect(assigns(:reservation)).to eq @reservation
      end
      it 'showテンプレートで表示されること' do
        expect(response).to render_template :show
      end
    end
  end
  describe '予約アクション（create）' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post :create, params: { reservation: FactoryBot.attributes_for(:reservation) }
        expect(response.status).to eq 302
      end

      it '予約が登録されること' do
        expect do
          post :create, params: { reservation: FactoryBot.attributes_for(:reservation) }
        end.to change(Reservation, :count).by(1)
      end

      it 'リダイレクトすること' do
        post :create, params: { reservation: FactoryBot.attributes_for(:reservation) }
        expect(response).to redirect_to Reservation.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post :create, params: { reservation: FactoryBot.attributes_for(:reservation,:invalid) }
        expect(response.status).to eq 200
      end

      it '予約が登録されないこと' do
        expect do
          post :create, params: { reservation: FactoryBot.attributes_for(:reservation,:invalid) }
        end.to_not change(Reservation, :count)
      end

      it 'newテンプレートで表示されること' do
        post :create, params: { reservation: FactoryBot.attributes_for(:reservation,:invalid) }
        expect(response).to render_template :new
      end

      it 'エラーが表示されること' do
        post :create, params: { reservation: FactoryBot.attributes_for(:reservation,:invalid) }
        expect(assigns(:reservation).errors.any?).to be_truthy
      end
    end
  end
  describe '予約アクション（destroy）' do
    let!(:reservation) { FactoryBot.create :reservation }

    it 'リクエストが成功すること' do
      delete :destroy, params: { id: reservation }
      expect(response.status).to eq 302
    end

    it 'ユーザーが削除されること' do
      expect do
        delete :destroy, params: { id: reservation }
      end.to change(Reservation, :count).by(-1)
    end

    it 'ユーザー一覧にリダイレクトすること' do
      delete :destroy, params: { id: reservation }
      expect(response).to redirect_to(delete_url)
    end
  end
  describe '予約削除ページ' do
    context "予約削除ページが正しく表示される" do
      before do
        get :delete
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'deleteテンプレートで表示されること' do
        expect(response).to render_template :delete
      end
    end
  end
  describe '予約確認ページ' do
    context "予約確認ページが正しく表示される" do
      before do
        get :confirm, params: { reservation: FactoryBot.attributes_for(:reservation) }
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'assigns confirm @reservation' do
        expect(assigns(:reservation)).to be_a_new Reservation
      end
      it 'confirmテンプレートで表示されること' do
        expect(response).to render_template :confirm
      end
    end
  end
  describe '予約確認ページから予約登録ページへ' do
    context "予約登録ページが正しく表示される" do
      before do
        get :back, params: { reservation: FactoryBot.attributes_for(:reservation) }
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'assigns back @reservation' do
        expect(assigns(:reservation)).to be_a_new Reservation
      end
      it 'backテンプレートで表示されること' do
        expect(response).to render_template :new
      end
    end
  end
  describe 'Ajaxアクション' do
    context "予約登録ページが正しく表示される" do
      before do
        get :ajax, params: { reservation: FactoryBot.attributes_for(:reservation) }, xhr: true
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'assigns ajax @reservation' do
        expect(assigns(:reservation)).to be_a_new Reservation
      end
      it 'ajaxテンプレートで表示されること' do
        expect(response).to render_template :ajax
      end
    end
  end
end
