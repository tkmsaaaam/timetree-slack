# timetree-slack

 - Ruby: 2.6.3

# 概要
 - TimeTreeからSlackへ通知を飛ばすアプリです。
 - 一回の通知で向こう一週間のイベントを取得

# 通知形式
 - イベントがある場合
```
今週の予定だよ!
イベント名*リンク付き
日時: mm/dd(aaa) hh:mm ~ hh:mm
作成者: 作成者のTimeTree登録ユーザー名
参加者: 参加者のTimeTree登録ユーザー名 , 参加者のTimeTree登録ユーザー名 , ...
```

 - イベントがない場合
```
今週の予定はないよ！`
```

# 事前準備
 - `Personal access token` に関する準備
    - [Personal access tokenを作成する](https://timetreeapp.com/developers/personal_access_tokens)
    - `/lib/event.rb` の `L4` にセットする
 - カレンダーIDを準備。
    - カレンダーのIDを取得する。（Web版の場合 https://timetreeapp.com/calendars/:calendar_id の `:calendar_id` の部分）
    - `/lib/app.rb` の `L10` にセットする
 - SlackのIncoming WebhookのURLを取得し `/lib/slack_message.rb` の `L9` にセットする。また任意でチャンネル、ユーザーネーム、アイコンをセットする。

# 環境構築
 - `Ruby: 2.6.3` の環境を構築する。
 - rootディレクトリで `bundle install` 実行する。

# 実行する
 - rootディレクトリで `ruby lib/app.rb` を実行する。

# URL
 - [TimeTree Developer Platform](https://developers.timetreeapp.com/ja)
 - [httparty](https://github.com/jnunemaker/httparty/)
 - [slack-notifier](https://github.com/stevenosloan/slack-notifier/)
