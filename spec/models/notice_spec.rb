require 'rails_helper'

RSpec.describe Notice, type: :model do
    context "データが正しく保存される" do
        before do
            @notice = Notice.new
            @notice.title = "営業時間の変更"
            @notice.content = "5月20日は21:00までの営業になります。"
            @notice.save
        end
        it "全て入力してあるので保存される" do
            expect(@notice).to be_valid
        end
    end
    context "タイトルが空欄でないこと" do
        before do
            @notice = Notice.new
            @notice.title = ""
            @notice.content = "5月20日は21:00までの営業になります。"
            @notice.save
        end
        it "タイトルが入力されていないので保存されない" do
            expect(@notice).to be_invalid
            expect(@notice.errors[:title]).to include("が入力されていません。")
        end
    end
    context "内容が201文字以内であること" do
        before do
            @notice = Notice.new
            @notice.title = "営業時間の変更"
            @notice.content = "5月20日は21:00までの営業になります。5月20日は21:00までの営業になります。5月20日は21:00までの営業になります。5月20日は21:00までの営業になります。5月20日は21:00までの営業になります。5月20日は21:00までの営業になります。5月20日は21:00までの営業になります。5月20日は21:00までの営業になります。5月20日は21:00までの営業になります。5月20日は21:00までの営業になります。5月20日は21:00までの営業になります。5月20日は21:00までの営業になります。"
            @notice.save
        end
        it "内容が200文字以上なので保存されない" do
            expect(@notice).to be_invalid
            expect(@notice.errors[:content]).to include("は200文字以下に設定して下さい。")
        end
    end
end