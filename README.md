# テーブルスキーマ

|Task   |      |  
|:--    |:--   |
|Column |Type  |
|name   |string|
|content|string|


## デプロイした手順
- heroku createでアプリケーションを作成
- Gemfileに以下のgemを追加
  - gem 'net-smtp'
  - gem 'net-imap'
  - gem 'net-pop'
- git add .
- git commit -m"コミットメッセージ"
- 作成したアプリケーションをHeroku上でコンパイルするため、以下の２つを追加
  - heroku buildpacks:set heroku/ruby
  - heroku buildpacks:add --index 1 heroku/nodejs
- git push heroku issues/#3:master このコマンドでデプロイ
- heroku run rails db:migrate　データベースの移行　
