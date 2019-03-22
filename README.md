# Quoridor(コリドール)

## Quoridorとは？

完全情報のアブストラクトゲーム．<br>
各プレイヤーはコマ1つと壁10個を所持している．<br>
ターン制で進行し，行動を以下から選択する．<br>

1. 自分のコマを上下左右1マス移動<br>
1. 好きな場所に手持ちの壁を設置する<br>

コマは壁を超えることができず，壁は完全に進行できなくなるような置き方ができない．<br>
コマが隣り合った場合は，相手のコマを跳び越すことができる．<br>
1手でも早く一番奥に到達できれば勝利．<br>

## 開発環境

### 言語
Ruby(OpalによりJavaScriptに変換される)

### ライブラリ
DxOpal

## 実行
```
# プロジェクトルートディレクトリに移動
$ cd quoridor/

# dxopalをインストール
$ gem install dxopal

# dxopalでサーバを起動
$ dxopal s

# ブラウザで localhost:7521/src/index.html にアクセス
```

## 開発者
* [bonochof](https://github.com/bonochof)
* [ko-ke-shi](https://github.com/ko-ke-shi)
