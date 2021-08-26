# Docker コンテナ

## 2 種類の Docker コンテナ

本書で使用しているツールやライブラリ一式をインストールした Docker コンテナを、
Docker Hub 上で公開しています。

- Debian GNU/Linux (bullseye) (i386) (32 ビット版)

    https://hub.docker.com/r/hohsaki/asm-i386

- Debian GNU/Linux (bullseye) (amd64) (64 ビット版)

    https://hub.docker.com/r/hohsaki/asm

IA-32 アーキテクチャ、COMET II、AVR アーキテクチャ、Armv8-A アーキテク
チャ向けのコンパイルやアセンブルには 32 ビット版をご利用ください。

Intel 64 アーキテクチャ向けのコンパイルやアセンブルには 64 ビット版を
ご利用ください。

Docker が利用できる環境であれば、
GNU/Linux、
macOS、
Windows いずれのオペレーティングシステムでも上記のコンテナを利用できます。
ただし、
コンテナのアーキテクチャが i386 および amd64 ですので、
インテルもしくは AMD の CPU を搭載したコンピュータが必要です。

Docker エンジンを動作させているホストコンピュータが 64 ビット (x86-64/amd64) でも、
32 ビット版のコンテナを動作させることができます。
したがって、
例えば 64 ビット版の Windows 上で、
32 ビット版 (i386) の Docker コンテナ (asm-i386) を利用できます。

Docker のインストール方法や利用法については、
以下のページをご覧ください。

- docker docs

    https://docs.docker.com/

## Docker コンテナの起動例

### root (スーパーユーザ) でシェルを起動する方法

Docker コンテナのシェルを直接起動するのが最も簡単な方法です。
 root (スーパーユーザ) としてシェルを起動しますが、
あくまでコンテナ内の root ですので特に危険ではありません。

```sh
$ docker run -it --rm hohsaki/asm-i386:1.0 /bin/bash ← コンテナを起動
WARNING: The requested image's platform (linux/386) does not match the detected host platform (linux/amd64) and no specific platform was requested
root@34efbca5c9d8:/home/asm# cd /home/asm/code/asm ← ソースコード一式がある
root@34efbca5c9d8:/home/asm/code/asm# gcc -o hello hello.c ← コンテナ上でコンパイル
root@34efbca5c9d8:/home/asm/code/asm# ./hello ← コンテナ上で実行
Hello, World!
root@34efbca5c9d8:/home/asm/code/asm# ^D ← ← コンテナを終了
```

Docker コンテナの性質上、
コンテナを終了すると、
作成・変更したファイルはすべて消えてしまいます。
作成・変更したファイルを残しておきたい場合は、
ホストのファイルシステムをマウントする等して、そこに保存してください。

```sh
$ mkdir ~/work ← 作業ディレクトリを作成
$ docker run -it --rm -v ~/work:/work hohsaki/asm-i386:1.0 /bin/bash ← 作業ディレクトリをマウント
WARNING: The requested image's platform (linux/386) does not match the detected host platform (linux/amd64) and no specific platform was requested
root@3f8b6bff6ec8:/# cd /work/ ← /work にマウントされている
root@3f8b6bff6ec8:/work# cp /home/asm/code/asm/hello.c . ← ここにプログラムをコピー
root@3f8b6bff6ec8:/work# gcc -o hello hello.c ← コンパイルし、実行ファイルを生成
root@3f8b6bff6ec8:/work# ^D ← コンテナを終了
exit
$ docker run -it --rm -v ~/work:/work hohsaki/asm-i386:1.0 /bin/bash ← コンテナを再起動
WARNING: The requested image's platform (linux/386) does not match the detected host platform (linux/amd64) and no specific platform was requested
root@ecb09453f83d:/# ls -l /work/hello ← さきほど作成した実行ファイルが残っているか?
-rwxr-xr-x 1 root root 15524 Aug 26 17:27 /work/hello ← 残っている!
```

### コンテナに SSH で接続する方法

```sh
$ docker run -d -p 3331:22 hohsaki/asm-i386:1.0 ← 3331 番ポートを 22 番にリダイレクトし、デーモンとして起動
WARNING: The requested image's platform (linux/386) does not match the detected host platform (linux/amd64) and no specific platform was requested
62c8e5e3ae2c6e3cf76816b4f520d0aa8423ed723d42c500d648f1a1389dadfd
$ ssh -p3331 asm@localhost ← 3331 番ポートに、ユーザ名 asm で SSH 接続
asm@localhost's password: as -a foo.s ← パスワードは「as -a foo.s」 (半角で 11 文字)
X11 forwarding request failed on channel 0
Linux 62c8e5e3ae2c 5.10.0-8-amd64 #1 SMP Debian 5.10.46-4 (2021-08-03) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
asm@62c8e5e3ae2c:~$ cd code/asm ← ソースコードをコンパイルおよび実行
asm@62c8e5e3ae2c:~/code/asm$ gcc -o hello hello.c 
asm@62c8e5e3ae2c:~/code/asm$ ./hello 
Hello, World!
```
