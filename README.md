# README

##自分の環境
- ruby 2.6.5
- rails 5.2.4
- PostgreSQL 12.2

##データベース関連
#### labelsテーブル
   
|Column|Type|
|------|----|
|title|string|

#### task_to_labelsテーブル
   
|Column|Type|
|------|----|
|task_id|bigint|
|label_id|bigint|
   
#### tasksテーブル

|Column|Type|
|------|----|
|task_name|string|
|description|text|
|deadline|date|
|status|string|
|rank|integer|
|user_id|bigint|
   
#### usersテーブル

|Column|Type|
|------|----|
|name|string|
|email|string|
|password_digest|string|
|admin|boolean|

##Herokuへのデプロイ手順
※HerokuアプリケーションURL:https://stormy-hollows-98258.herokuapp.com

1. 作業ブランチからmasterブランチへプルリクエスト、マージする

1. ローカルのmasterブランチを最新の情報に更新する。
    
        $ git pull origin master

1. アセットプリコンパイルを行い、本番環境で利用するためのアセットファイルを生成する。
   
        $ rails assets:precompile RAILS_ENV=production

1. Herokuに新しいアプリケーションを作成する。
   ローカルのアプリケーションディレクトリ内で、下記コマンドを入力する。
        
        $ heroku create
                    
1. Herokuへデプロイする。

        $ git add .
    
        $ git commit -m "コミット文"
    
        $ git push heroku master
        
1. Herokuデータベースのマイグレーションを行う。
                
        $ heroku run rails db:migrate
        
1. 上記までが初回のデプロイ手順。
   
   2回目以降のデプロイは、GitHubとHerokuを連携させているため、
   GitHubのmasterにコードがマージ（PRがマージ）されたら、
   その内容が自動でHerokuにpushされるように設定している。
