フォームからのデータの保存方法について
createアクションはフォームで送られてきたデータを元に、レコードを保存する
ストロングパラメーターを使用した保存方法


ストロングパラメーター
ストロングパラメーターとは、
指定したキーを持つパラメーターのみを受け取るように制限するもの。
ストロングパラメーターを使用する理由は、
受け取るパラメーターを制限しなければ、
仕様以外のパラメーターも使われてしまうためである。
この状態だと、意図しないデータの更新をされる可能性が発生する。
(他人のログインパスワードを変更するパラメーターを追加で送信すれば、勝手にパスワードを変更できてしまう)
これを回避するために、ストロングパラメーターを使用し、パラメーターを制限する必要がある
ストロングパラメーターの定義には、requireメソッドと、permitメソッドを組み合わせて使用する。


requireメソッド
送信されたパラメーターの情報を持つparamsが、使用できるメソッド。
requireメソッドは、パラメーターからどの情報を取得するか、選択する。
ストロングパラメーターとして使用する場合は、主にモデル名を指定する。
【例】require
params.require(:モデル名)  # 取得したい情報を指定する

params[:モデル名]としても同じ情報を取得できるが、
requireメソッドを使うことで、
意図しないパラメーターであった場合にエラーとして返すことができ、
原因特定やユーザーにエラーを示すなどの対応ができる。
以上のように、
requireメソッドによって必要なパラメーターのほとんどを取得できるが、
取得するパラメーターをより意図したものだけに制限するため、
permitメソッドを使用して、
カラムに保存したいデータのみに絞る。


permitメソッド
requireメソッドと同様に、paramsが使用できるメソッド。
permitメソッドを使用すると、
取得したいキーを指定でき、指定したキーと値のセットのみを取得する。
【例】permit
params.require(:モデル名).permit(:キー名, :キー名) # 取得したいキーを指定する

permitメソッドでparams.requireの内容からキーを指定すると、
それ以外のキーがあっても値を受け付けない。


プライベートメソッド
クラス外から呼び出すことのできないメソッドのこと。

プライベートメソッドのメリットは以下の2点
1. Classの外部から呼ばれたら困るメソッドを隔離
メソッドの中には、
Classの外部から呼び出されてしまうとエラーを起こすメソッドも存在する。
プライベートメソッドはClass外から呼び出すことが不可能であるため、
誤って呼び出してしまう等によるエラーを事前に防ぐことができる。

2. 可読性
Classの外部から呼び出されるメソッドを探すときに、
private以下の部分は目を通さなくて良くなる。
また、繰り返し使用するメソッドもprivate以下に集約できるので、
コードをシンプルにできる。



データの入力に制約をかける
バリデーション
データを登録する際に、一定の制約をかけること。
・空のデータが登録できないようにする
・すでに登録されている文字列を登録できないようにする（メールアドレスの登録など）
・文字数制限をかける（パスワードなど）
バリデーションを設ける際は、モデルにvalidatesメソッドを記述する。

validates
validatesとは、バリデーションを設定する時に使用するメソッド。
【例】モデルファイル
validates :カラム名, バリデーションの種類

presence: trueと記述することで、
nameカラムが「空ではないか」というバリデーションを設ける
【例】モデルファイル
validates :name, presence: true

このバリデーションを設けることで、
名前が空欄の時データベースに保存できなくなる。
つまり、値を必ず入力しなければ、登録する時エラーが発生する。


HTTPメソッドのおさらい
・GETメソッド
サーバーからブラウザに情報を返す。
単にウェブサイトを閲覧する際など、情報を取得するために利用される。

・POSTメソッド
ブラウザからサーバーに情報を送信し、サーバーに情報を保存する。
情報を登録する際など、サーバーに情報を送信するために利用される。

・DELETEメソッド
ブラウザからサーバーに情報を送信し、サーバーの情報を削除する。
アカウントを削除する際など、サーバー内のデータを削除するために利用される。

・PATCHメソッド
ブラウザからサーバーに情報を送信し、サーバー内の情報を置き換える。
登録情報を更新する際など、サーバー内のデータを更新するために利用される。

Railsではこれら4つのメソッドを利用して開発を行なっており、その役割や機能が分かれている。



メソッドによるコード省略
同じコードをメソッドにまとめる
・before_action
before_actionを使用すると、
コントローラで定義されたアクションが実行される前に、共通の処理を行うことができるメソッド。
【例】before_action
class コントローラ名 < ApplicationController
  before_action :処理させたいメソッド名, オプション名
end

・onlyオプション
resourcesと同様にonlyやexceptなどのオプションを使用することによって、
どのアクションの実行前に、処理を実行させるかなど制限が可能になる。



ライブラリをインストール
ログイン機能を実装するために、deviseというGemを使用
・devise
ユーザー管理機能を簡単に実装するためのGem。
実際に運用されている多くのRailsアプリケーションサービスで使用されている。

追記する場所は、Gemfileの最後の行
Gemfile
# 中略
gem 'devise'

コマンドを実行してGemをインストール
ターミナル
# 現在のディレクトリが~/projects/pictweetであることを確認
% pwd

# Gemをインストール
% bundle install

ローカルサーバーを再起動
Gemをインストールした後はrails sをcontrol + Cで一度停止し、
サーバーを再起動する必要がある。
これは、インストールしたGemの反映するタイミングが、サーバー起動時だからである。
ターミナル
# サーバーを起動
% rails s


deviseの設定ファイルを作成
deviseを使用するためには、Gemのインストールに加え、
devise専用のコマンドで設定ファイルを作成する必要がある。

rails g devise:installコマンド
このコマンドは、
追加したdeviseというGemの「設定関連に使用するファイル」を自動で生成するコマンド。

コマンドを実行して設定ファイルを作成
ターミナル
# deviseの設定ファイルを作成
% rails g devise:install



deviseのUserモデルを作成
deviseを利用する際には、
アカウントを作成するためのUserモデルを新しく作成する必要がある。
作成には通常のモデルの作成方法ではなく、
deviseのモデル作成用コマンドでUserモデルを作成する。

rails g deviseコマンド
rails g deviseコマンドは、
deviseによるユーザー機能の対象を指定することで、
モデルとマイグレーションの生成やルーティングの設定などをまとめて処理できる。
実行すると、モデルが生成され、routes.rbにはdeviseに関連するパスが追加される。

コマンドを実行してUserモデルを作成
rails g deviseコマンドでuserを指定
ターミナル
# deviseコマンドでUserモデルを作成
% rails g devise user

ユーザーに関する、モデルやマイグレーションも自動生成される。
また、routes.rbに以下のルーティングが自動的に追記される。
【例】config/routes.rb
Rails.application.routes.draw do
  devise_for :users
end

devise_forは、
ユーザー機能に必要な複数のルーティングを一度に生成してくれるdeviseのメソッド。
※モデルとマイグレーションは作成されるが、usersテーブルは作成されていない。
そのため、このコマンドを実行した後にhttp://localhost:3000へアクセスするとエラーが生じる。
rails db:migrateを実行する必要があるが、
カラムのなど追加する必要がある場合、編集してからマイグレートを実行する。



deviseのビューファイルを作成
deviseでログイン機能を実装すると、
ログイン/サインアップ画面が自動的に生成されるが、
ビューファイルとしては生成されない。
これは、deviseのGem内に存在するビューファイルを読み込んでいるためである。
deviseのビューファイルに変更を加えるためには、
deviseのコマンドを利用して、ビューファイルを生成する必要がある。

rails g devise:viewsコマンド
deviseに用意されたビューファイルをコピーし、app/viewsの配下に配置してくれるコマンド。
HTMLを修正できるため、カスタマイズ可能になる。

コマンドを実行してdevise用のビューを作成
ターミナル
% rails g devise:views



ログイン・サインアップ画面のビューを編集
・サインアップ画面のビュー
app/views/devise/registrations/new.html.erb
・ログイン画面のビュー
app/views/devise/sessions/new.html.erb



usersテーブルにカラムを追加
現在、サインアップ時に登録する情報はメールアドレスとパスワードの2つ。
これに加えてニックネームを登録できるようにする。
テーブルにカラムを追加するために、マイグレーションを生成する必要がある。

rails g migrationコマンド
マイグレーションを生成するコマンド
このコマンドは、指定するファイルの名前によって、
どのようなテーブル操作を行うかを自動で記述する。
rails g migration Addカラム名To追加先テーブル名 追加するカラム名:型
とすることで、テーブルにカラムを追加する際に必要なコードが記述された状態で、マイグレーションが生成される。

スネークケースとキャメルケース
スネークケースとキャメルケースは、それぞれ単語の区切り方を表したもの
・スネークケースは、単語の区切りをアンダースコアで表す
admin_user_comment_creator
・キャメルケースは、単語の区切りを大文字で表す
adminUserCommentCreator
・アッパーキャメルケースは、キャメルケースの1つ。先頭から単語の区切りを大文字で表す
AdminUserCommentCreator


Railsの慣習的な命名規則
クラス名：アッパーキャメルケース
メソッド名：スネークケース
変数名：スネークケース


usersテーブルにnicknameカラムをstring型で追加
ユーザー名を保存するために新しいカラムを1つ追加する。
今回はこのカラム名をnicknameとする。マイグレーションファイルの作成と実行をする。
ターミナル
# ディレクトリがpictweetであることを確認
% pwd

# usersテーブルにnicknameカラムをstring型で追加するマイグレーションファイルを作成
% rails g migration AddNicknameToUsers nickname:string

# 作成したマイグレーションを実行
% rails db:migrate

※Addカラム名To追加先テーブルのカラム名の部分は、
必ずしも厳密なカラム名を入力する必要はない。
ただし、ファイル名を見ただけで動作を理解できる名前にしておくのが適切。
今回はnicknameというカラムを追加するのでNicknameと記述。