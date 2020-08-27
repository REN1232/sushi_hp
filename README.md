## sushi_hp
http://http://13.230.33.144//  

![demo](https://github.com/KAGIREN/sushi_hp/wiki/images/tukijisushi.work_.png)

## 管理者ログイン
ゲストログイン機能有り  
Email sushi@co.jp  
password sushisushi

## サイトの説明
個人店のお寿司屋さんのHPを意識して作りました。

## バージョン
・ruby 2.5.7  
・Rails 5.2.4.1  

## 使用技術

### 開発環境
・Vagrant + VirtualBox

### インフラ
・AWS(EC2, RDS, Route53)  
・MySQL2  
・Nginx(Webサーバ)

### Gem・APIなど
・Rspec (モデルテスト、コントローラテスト、フィーチャーテスト)  
・devise (認証機能)  
・dotenv-rails (環境変数管理)  
・I18n (日本語化)  
・GoogleMapsAPI (地図表示)  
・refile（画像表示）  
・refile-mini_magick（画像表示）  
・bootstrap-sass  
・jquery-rails（Jquwry機能）  
・fullcalendar-rails（カレンダー機能）  
・momentjs-rails(カレンダー日時)  
・kaminari（ページネーション）  
・Ajax(絞り込み、動き)  

## 機能

### HP側
・カレンダーでの予約登録  
・予約登録時の時間帯と人数の絞り込み  
・予約登録確認画面の表示  
・お知らせ詳細ページでの投稿前後リンク

### 管理者側
・ログイン機能  
・お知らせ追加、編集、削除  
・お知らせ詳細ページでの投稿前後リンク  
・予約一覧表示（条件での絞り込み、検索機能  
・カレンダーでの予約登録  
・予約登録時の時間帯と人数の絞り込み  
・予約追加、編集、削除

## デモ
いくつかの機能をピックアップして紹介します。

## カレンダー機能での予約登録
カレンダーをタップすることで日付を取得できます。  

![demo](https://github.com/KAGIREN/sushi_hp/wiki/images/image.gif)

## 予約登録時の時間帯と人数の絞り込み
日時が入力された状態で時間帯か人数のどちらかを入力します。  
その後に残りのもう片方を選択しますとその時に可能な選択肢のみが表示されます。  

![demo](https://github.com/KAGIREN/sushi_hp/wiki/images/image2.gif)

## 予約一覧の検索
日付と時間帯（1日、ランチ、ディナー）で予約のデータを絞って表示することができます。  

![demo](https://github.com/KAGIREN/sushi_hp/wiki/images/image3.gif)

## インストール　
```
$ git clone https://github.com/KAGIREN/sushi_hp
$ cd sushi_hp
$ bundle install
$ rails db:migrate
$ rails db:seed
```
## 作者
[KAGIREN](https://github.com/KAGIREN)


