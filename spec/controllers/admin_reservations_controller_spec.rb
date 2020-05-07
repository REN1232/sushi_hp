require 'rails_helper'

RSpec.describe Admin::ReservationsController, type: :controller do
  let(:admin) { create(:admin) }
  before do
    sign_in(admin)
  end
  describe '予約一覧ページ' do
    context "予約一覧ページが正しく表示される" do
      let(:reservations) { create_list :reservation, 2 }
      before do
        get :index
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'assigns @reservations' do
        expect(assigns(:reservations)).to match_array reservations
      end
      it 'indexテンプレートで表示されること' do
        expect(response).to render_template :index
      end
    end
  end
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
  describe '予約編集ページ' do
    context "予約編集ページが正しく表示される" do
      before:each do
        @reservation = create(:reservation)
        get :edit, params: { id: @reservation }
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'assigns @reservation' do
        expect(assigns(:reservation)).to eq @reservation
      end
      it 'editテンプレートで表示されること' do
        expect(response).to render_template :edit
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
        expect(response).to redirect_to (admin_reservation_path(Reservation.last))
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post :create, params: { reservation: FactoryBot.attributes_for(:reservation,:invalid) }
        expect(response.status).to eq 200
      end

      it '予約が登録されないこと' do
        expect do
          post :create, params: { reservation: FactoryBot.attributes_for(:reservation, :invalid) }
        end.to_not change(Reservation, :count)
      end

      it 'newテンプレートで表示されること' do
        post :create, params: { reservation: FactoryBot.attributes_for(:reservation, :invalid) }
        expect(response).to render_template :new
      end

      it 'エラーが表示されること' do
        post :create, params: { reservation: FactoryBot.attributes_for(:reservation, :invalid) }
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

    it '予約が削除されること' do
      expect do
        delete :destroy, params: { id: reservation }
      end.to change(Reservation, :count).by(-1)
    end

    it '予約一覧にリダイレクトすること' do
      delete :destroy, params: { id: reservation }
      expect(response).to redirect_to(admin_reservations_path)
    end
  end
  describe '予約アクション（update）' do
    let!(:reservation) { create(:reservation) }
    let(:update_reservations) do
      {
          customer_name: 'update 築地寿司',
      }
    end

    it 'リクエストが成功すること' do
      expect do
        patch :update, params: { id: reservation.id, reservation: update_reservations }, session: {}
      end.to change(Reservation, :count).by(0)
    end

    it '名前が更新されること' do
      patch :update, params: { id: reservation.id, reservation: update_reservations }, session: {}
      reservation.reload
      expect(reservation.customer_name).to eq update_reservations[:customer_name]
    end

    it 'リダイレクトすること' do
      patch :update, params: { id: reservation.id, reservation: update_reservations }, session: {}
      reservation = Reservation.last
      expect(response).to redirect_to(admin_reservation_path(reservation))
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        put :update, params: { id: reservation.id, reservation: FactoryBot.attributes_for(:reservation,:invalid) }
        expect(response.status).to eq 200
      end

      it '名前が変更されないこと' do
        expect do
        put :update, params: { id: reservation.id, reservation: FactoryBot.attributes_for(:reservation,:invalid) }
        end.to_not change(Reservation.find(reservation.id), :customer_name)
      end

      it 'editテンプレートで表示されること' do
        put :update, params: { id: reservation.id, reservation: FactoryBot.attributes_for(:reservation,:invalid) }
        expect(response).to render_template :edit
      end

      it 'エラーが表示されること' do
        put :update, params: { id: reservation.id, reservation: FactoryBot.attributes_for(:reservation, :invalid) }
        expect(assigns(:reservation).errors.any?).to be_truthy
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
