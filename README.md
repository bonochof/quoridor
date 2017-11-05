# Quoridor(コリドール)

## Quoridorとは？

非常に簡単なアブストラクトゲーム．

各プレイヤーはコマ1つと壁10個を所持している．

ターン制で進行し，行動を以下から選択する．

1. 自分のコマを上下左右1マス移動
1. 好きな場所に手持ちの壁を設置する

コマは壁を超えることができず，壁は完全に進行できなくなるような置き方ができない．

コマが隣り合った場合は，相手のコマを跳び越すことができる．

1手でも早く一番奥に到達できれば勝利．

## 実行手順
```
$ gem install dxruby
$ cd src
$ ruby main.rb
```

## 開発環境

### 言語
Ruby

### ライブラリ
DxRuby

## 開発者
* [bonochof](https://github.com/bonochof)
* [ko-ke-shi](https://github.com/ko-ke-shi)
