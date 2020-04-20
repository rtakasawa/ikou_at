# README

##データベース関連

- テーブル名：tasks
    - カラム（データ型）
        - task_name（string）
        - description(text)
        
##Herokuへのデプロイ手順
1. 作業ブランチからmasterブランチへプルリクエスト、マージする
1. ローカルのmasterブランチを最新の情報に更新する
    
        $ git pull origin master
    
1. Herokuへのデプロイするため下記コマンドをターミナルに入力する

        $ git add .
    
        $ git commit -m "コミット文"
    
        $ git push heroku master

※HerokuURL:https://stormy-hollows-98258.herokuapp.com
