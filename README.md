# CPU+コンパイラ自作キャンプ

cccamp は [CPU+コンパイラ自作キャンプ](https://scrapbox.io/uchan/CPU+%E3%82%B3%E3%83%B3%E3%83%91%E3%82%A4%E3%83%A9%E8%87%AA%E4%BD%9C%E3%82%AD%E3%83%A3%E3%83%B3%E3%83%97)
のサンプルコードを提供するためのリポジトリです。

CPU+コンパイラ自作キャンプとは、CPU とコンパイラを同時並行に作ることを通してコンピュータの動作原理を深く理解しようという教材です。

## 動作環境

FPGA 開発ツールの Gowin EDA は Windows と Linux のバージョンがありますが、
本リポジトリに含まれるスクリプト類は、現状 Windows 11 の WSL 環境で使うことを前提にしています。
WSL 以外の Linux 環境で使うには調整が必要です。

例えば [scripts/gw_prog.sh](./scripts/gw_prog.sh) は WSL 専用になっていますから、そのままでは WSL でない環境では使えません。
本リポジトリのスクリプト類を WSL 以外の Linux 環境でも動くように修正するプルリクエストを募集しています。

## 初期設定

必要な初期設定は次の通りです。

1. Gowin EDA for Windows をインストールする。（WSL ではなく、ホストの Windows 環境にインストールする。）
2. 本リポジトリをローカルに git clone する。
3. make と iverilog を WSL にインストールする。（`sudo apt install make iverilog`）
4. scripts/user.env.sample を scripts/user.env としてコピーし、中身を適切に編集する。

## 動作確認

初期設定が終わったら、動作確認のため verilog_practice/led_pattern をシミュレーションおよび FPGA 実機で実行してみてください。

シミュレーション実行は次の通りです。WSL のシェルで実行してください。

    $ cd verilog_practice/led_pattern
    $ make sim
    iverilog -g2012 -o sim.exe main_tb.sv main.sv
    ./sim.exe
        0 led=001010

最後の行がシミュレーション結果です。この行が出なければ何かおかしいことが起きています。

## ライセンス

このリポジトリに含まれるプログラムやドキュメントは、特別の記載がある場合を除き、MIT ライセンスで提供されます。
ライセンス本文は [LICENSE](./LICENSE) です。
