# 概要
golangサンプル

# 使い方
## 必要環境
- node v12.8.1 or later
  - for react-scripts 3.1.0
   
## repo
```bash
git clone <github url> <dir>
cd <dir>
```
## 証明書作成
nginxで証明書を使用するため、それの準備を行う
```
make cert
```

## 起動
cloneして `make up` すれば動きます。
```bash
make up
```

# 動作確認
ブラウザから `localhost:8080` にアクセスして画面が出ればOKです。

# 開発
## protobuf更新
下記実行
```bash
make proto
```

# デバッグ
## realize(goのホットデプロイ用ツール)
ブラウザからlocalhost:5002にアクセスすると管理画面が見れます。
