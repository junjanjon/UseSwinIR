# SwinIRを使った画像高画質化スクリプト

スクリプトの記録

## 使い方

main.sh の `python SwinIR/main_test_swinir.py` の引数部分を変更することで指定ディレクトリの画像（png,jpg）を一括で高画質化（4倍サイズの超解像）します。

```shell
# require python3, venv, git, curl
./main.sh
```

2020 MacBook Pro での実行時間は 500x500 => 2000x2000 の画像 1 枚約 5 分程度だった。

## 参考

- [JingyunLiang/SwinIR: SwinIR: Image Restoration Using Swin Transformer (official repository)](https://github.com/JingyunLiang/SwinIR)
- [Web制作時に高解像度の元画像がない場合にPythonで高画質化する方法](https://alaki.co.jp/blog/?p=4208)
- [「SwinIR」で高画質化した画像を pythonを使用して一括で元のサイズに戻す方法](https://alaki.co.jp/blog/?p=4342)
