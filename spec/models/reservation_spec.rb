require 'rails_helper'

RSpec.describe Reservation, type: :model do
    context "データが正しく保存される" do
        before do
            @reservation = FactoryBot.create(:reservation)
            @reservation.save
        end
        it "全て入力してあるので保存される" do
            expect(@reservation).to be_valid
        end
    end
    context "名前が空欄でないこと" do
        before do
            @reservation = FactoryBot.create(:reservation)
            @reservation.customer_name = ""
            @reservation.save
        end
        it "名前が入力されていないので保存されない" do
            expect(@reservation).to be_invalid
            expect(@reservation.errors[:customer_name]).to include("が入力されていません。")
        end
    end
    context "名前が20文字以内であること" do
        before do
            @reservation = FactoryBot.create(:reservation)
            @reservation.customer_name = "築地寿司築地寿司築地寿司築地寿司築地寿司築地寿司"
            @reservation.save
        end
        it "名前が20文字以上なので保存されない" do
            expect(@reservation).to be_invalid
            expect(@reservation.errors[:customer_name]).to include("は20文字以下に設定して下さい。")
        end
    end
    context "人数が空欄であること" do
        before do
            @reservation = FactoryBot.create(:reservation)
            @reservation.people = ""
            @reservation.save
        end
        it "人数が空欄なので保存されない" do
            expect(@reservation).to be_invalid
            expect(@reservation.errors[:people]).to include("が入力されていません。")
        end
    end
    context "enum(:people)が正しく設定されていること" do
        describe 'enum(:people)' do
            it { is_expected.to define_enum_for(:people).with_values(%i[1 2 3 4 5 6 7 8 9 10]) }
        end
    end
    context "予約時間が空欄であること" do
        before do
            @reservation = FactoryBot.create(:reservation)
            @reservation.reservation_time = ""
            @reservation.save
        end
        it "予約時間が空欄なので保存されない" do
            expect(@reservation).to be_invalid
            expect(@reservation.errors[:reservation_time]).to include("が入力されていません。")
        end
    end
    context "enum(:reservation_time)が正しく設定されていること" do
        describe 'enum(:reservation_time)' do
            it { is_expected.to define_enum_for(:reservation_time).with_values(%i[11:00 12:00 13:00 14:00 17:00 18:00 19:00 20:00 21:00]) }
        end
    end
    context "予約日時が空欄であること" do
        before do
            @reservation = FactoryBot.create(:reservation)
            @reservation.reservation_day = ""
            @reservation.save
        end
        it "予約日時が空欄なので保存されない" do
            expect(@reservation).to be_invalid
            expect(@reservation.errors[:reservation_day]).to include("が入力されていません。")
        end
    end
    context "電話番号が空欄であること" do
        before do
            @reservation = FactoryBot.create(:reservation)
            @reservation.phone_number = ""
            @reservation.save
        end
        it "予約日時が空欄なので保存されない" do
            expect(@reservation).to be_invalid
            expect(@reservation.errors[:phone_number]).to include("が入力されていません。")
        end
    end
    context "電話番号が10文字以上であること" do
        before do
            @reservation = FactoryBot.create(:reservation)
            @reservation.phone_number = "000"
            @reservation.save
        end
        it "電話番号が10文字以上なので保存されない" do
            expect(@reservation).to be_invalid
            expect(@reservation.errors[:phone_number]).to include("は10文字以上に設定して下さい。")
        end
    end
    context "電話番号が11文字以下であること" do
        before do
            @reservation = FactoryBot.create(:reservation)
            @reservation.phone_number = "000000000000000"
            @reservation.save
        end
        it "電話番号が11文字以下なので保存されない" do
            expect(@reservation).to be_invalid
            expect(@reservation.errors[:phone_number]).to include("は11文字以下に設定して下さい。")
        end
    end
    context "メールアドレスが空欄であること" do
        before do
            @reservation = FactoryBot.create(:reservation)
            @reservation.email = ""
            @reservation.save
        end
        it "メールアドレスが空欄なので保存されない" do
            expect(@reservation).to be_invalid
            expect(@reservation.errors[:email]).to include("が入力されていません。")
        end
    end
    context "メールアドレスが正しくない場合、保存されないこと" do
        before do
            @reservation = FactoryBot.create(:reservation)
            @reservation.email = "test"
            @reservation.save
        end
        it "メールアドレスが正しくないので保存されない" do
            expect(@reservation).to be_invalid
            expect(@reservation.errors[:email]).to include("は有効でありません。")
        end
    end
end