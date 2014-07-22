Crypto
======
Tweet Decoder for mikutter

# なにこれ
狂人がよく base64 でエンコードしてツイートする……だけに留まらず、gzip してみたり、rot13 とか rot47 してツイートしているので、そいつらをさくっと読むためのプラグインです。


# インストール方法

    $ mkdir -p ~/.mikutter/plugin; git clone https://github.com/osyoyu/mikutter-crypto ~/.mikutter/plugin/crypto


# 使い方
頭のおかしいツイートのコンテキストメニューを出して、それっぽい項目を選ぶと、activity タブに結果が流れます。
「自動でデコードする」を選ぶと、base64 としてデコード / gzip として展開の両方に失敗するまで試行を繰り返します。頭のおかしい人間が `gzip | base64 | gzip | gzip | base64 | base64` とかしてても大丈夫です。


# 対応しているデータフォーマットなど
* base64
* gzip
* ROT13
* ROT47
