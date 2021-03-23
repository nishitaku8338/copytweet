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



サインアップ画面を編集
ニックネーム情報をフォームから登録できるようにビューを編集する。
今回は、ニックネームを6文字以内で登録させるようにする。
このような文字数上限を設定する際に必要な、maxlengthオプションを使う。

maxlengthオプション
maxlengthオプションは、inputタグを生成するヘルパーメソッドである。
text_fieldにつけることができるオプションである。
入力できる最大文字数を指定できる。
【例】maxlengthオプション
<div class="field">
  <%= f.text_field :nickname, autofocus: true, maxlength: "6" %>
</div>

上記の場合、生成されたフォームに7文字以上入力すると、
エンターキーを押した瞬間に6文字になるまでカットされる。



ストロングパラメーターを使えるように
deviseに関しても、同様にストロングパラメーターをコントローラーに記述する。
しかし、deviseの処理を行うコントローラーはGem内に記述されているため、編集することができない。
また、deviseでログイン機能を実装した場合は、
paramsの他に、paramsとは異なる形のパラメーターも受け取っている。
以上から、deviseのコントローラーにストロングパラメーターを反映する方法と、
devise特有のパラメーターを取得する方法が、必要になる。
まずはdevise特有のパラメーターを取得するために、
deviseが提供しているdevise_parameter_sanitizerというメソッドを使う。

devise_parameter_sanitizerメソッド
deviseにおけるparamsのようなメソッド。
deviseのUserモデルに関わる「ログイン」「新規登録」などのリクエストからパラメーターを取得できる。
このメソッドとpermitメソッドを組み合わせることにより、
deviseに定義されているストロングパラメーターに対し、
自分で新しく追加したカラムも指定して含めることができる。

devise_parameter_sanitizerメソッドは、
これまでのストロングパラメーターと同じく、
新たに定義するプライベートメソッドの中で使用する。
deviseの提供元では、新たに定義するメソッド名を
configure_permitted_parameters
と紹介していることから、慣習的にこのメソッド名で定義することが多い。
【例】devise_parameter_sanitizerメソッド
private
def configure_permitted_parameters  # メソッド名は慣習
  # deviseのUserモデルにパラメーターを許可
  devise_parameter_sanitizer.permit(:deviseの処理名, keys: [:許可するキー])
end

ただし、あくまで慣習なので定義するメソッド名は自由につけても構話ない。

また、devise_parameter_sanitizerに使用するpermitメソッドの引数が、
これまでと異なる点に注目。
これは、deviseに定義されているpermitメソッドであり、
Railsではじめから使用できたpermitメソッドとは異なるものであるため。
【例】名前は同じでも、中身は異なるpermit
# paramsのpermitメソッド
params.require(:モデル名).permit(:許可するキー)

# devise_parameter_sanitizerのpermitメソッド
devise_parameter_sanitizer.permit(:deviseの処理名, keys: [:許可するキー])


deviseのpermitは、
第一引数にdeviseの処理名、
第二引数にkeysというキーに対し、
配列でキーを指定することで、許可するパラメーターを追加します。

第一引数の処理名には、deviseですでに設定されているsign_in,
sign_up, account_updateが使用でき、
それぞれサインイン時やサインアップ時、アカウント情報更新時の処理に対応する。

処理名            役割
:sign_in         サインイン（ログイン）の処理を行うとき
:sign_up         サインアップ（新規登録）の処理を行うとき
:account_update  アカウント情報更新の処理を行うとき

第一引数で指定した処理に対して、
第二引数のkeysで指定された名前と同じキーを持つパラメーターの取得を許可する。
ビューに記述した各フォーム部品のname属性値が、フォームから送信されるパラメーターのキーとなる。

deviseにストロングパラメーターを追加するコードは、
deviseのコントローラーが編集できないため、application_controller.rbに記述する。


application_controller.rbファイル
すべてのコントローラーが継承しているファイル。
すなわち、ここに処理を記述しておくことで、すべてのコントローラーで共通となる処理を作ることができる。
これまで作成したtweets_controller.rbやdeviseのコントローラーも、
application_controller.rbの処理が読み込まれた上で作られる仕組みになっている。

※deviseの処理に関わるコントローラーはGemに記述されており、編集ができない。
そのため、編集ができるapplication_controller.rbにストロングパラメーターを定義しておき、その処理を読み込ませる。


ブラウザで登録画面を確認
http://localhost:3000/users/sign_up



UI/UXを整える
ログインの有無で表示を変える
ヘッダー部分のHTMLは、すべてのビューで共通のテンプレートである
application.html.erbで編集できる。
application.html.erbを編集して、
未ログイン時とログイン時でボタンの表示を変える実装をする。
ログイン状態の確認には、user_signed_in?メソッドを使用する。

user_signed_in?メソッド
Gemのdeviseを導入しているため、使用できるメソッド。
ログインしているかどうかの判定を行う。
user_signed_in?メソッドは、
ユーザーがログインしていればtrueを、
ログアウト状態であればfalseを返す。
【例】user_signed_in?
# ログインしているユーザーのとき
user_signed_in?
#=> true

# ログインしていないユーザーのとき
user_signed_in?
#=> false


link_toで作成したリンクは、デフォルトでGETメソッドを使用している。
そのため、DELETEメソッドを使用する際はmethodオプションに:deleteの指定が必要。
GETメソッドを使用する場合は、methodオプションを省略できる。
また、ログアウト以外にはclassオプションを使い、class属性をつけることで、CSSが適用されるようにする。



未ログイン状態のユーザーを転送
ログインしてない状態でも、「投稿する」ボタンの遷移先であるURLを直接入力すると、
新規投稿ページにアクセスできてしまう。
そこで、未ログインユーザーが投稿画面など直接アクセスしてきた際には、
ルートパスに遷移するように設定を行う。
このような仕組みをリダイレクトと言う。
tweets_controller.rbのすべてのアクションに対して、
「もし、ユーザーがログインしていなかったらindexアクションにリダイレクトする」ような機能を実装。

リダイレクト
「本来受け取ったパスとは別のパスへ転送する」機能のこと。
リダイレクトを利用すると、アクションに処理を持たせて実行した上で、
そのパスのビューを返すのではなく別の意図したパスにユーザーを転送させることができる。
今回は未ログインユーザを別のパスへ転送するため、
未ログインユーザを判別する必要がある。
この判別には、user_signed_in?とunlessを用いる。

unless
ifと同様に、条件式の返り値で条件分岐して処理を実行するRubyの構文。
ifは返り値がtrueのときにelseまでの処理が実行されるが、
unlessはfalseのときにelseまでの処理が実行される。
【例】unless
unless 条件式
  # 条件式がfalseのときに実行する処理
end 

このunlessを用いて「ログインしているユーザーでない」ときの処理に、
リダイレクトを設定する。
Railsではリダイレクト処理に、redirect_toメソッドを使用する。

redirect_toメソッド
Railsでリダイレクト処理を行う際に使用するメソッド。
コントローラー等での処理が終わった後、
アクションに対応するビューファイルを参照せずに、
別ページへリダイレクトさせることができる。
【例】redirect_to
redirect_to action: :リダイレクト先となるアクション名

今回はリダイレクト処理を定義して、before_acitionで実行させますが、
一部のアクションについては処理を実行させたくないため、
exceptオプションを使用し指定する必要がある。

exceptオプション
before_actionで使用できるオプション。
exceptは「除外する」という意味。
exceptと指定したアクションに対しては、事前処理は実行されない。

要点チェック
deviseとは、ユーザー管理機能を簡単に実装するためのGemのこと
rails g devise:install コマンドとは、deviseというGemの設定関連に使用するファイルを自動で生成するコマンドのこと
rails g deviseコマンドとは、deviseの中で使用するユーザーモデルclass名を置き換え、modelなど必要なファイルを生成するコマンドのこと
rails g devise:viewsコマンドとは、deviseで自動生成されたログインや新規作成画面を変更する際に使用するコマンドのこと
user_signed_in?メソッドとは、ログインしているユーザー情報を取得するメソッドのこと
リダイレクトとは、「本来受け取ったパスとは別のパスへ転送する」こと
redirect_toメソッドとは、指定先にリダイレクトさせるメソッドのこと
rails g migrationコマンドとは、マイグレーションファイルを生成するためのコマンド。命名規則に沿うと、必要なマイグレーションが記述された状態で生成されること
スネークケースとキャメルケースとは、複数の単語が連立する場合に使用する命名パターンのこと
devise_parameter_sanitizerメソッドとは、deviseでユーザー登録する場合に使用できる、「特定のカラムを許容する」メソッドのこと
application_controller.rbファイルとは、rails g controllerが生成するコントローラーが予め継承しているコントローラーのこと



ツイート保存時にユーザー情報も追加
tweetsテーブルにuser_idカラムが追加され、
このuser_idカラムに、ツイートを投稿したユーザーのidを保存する処理を記述する。
ツイートを投稿したユーザーとはつまり、現在ログインしているユーザーのこと、
そのため、tweetsテーブルのuser_idカラムに保存すべき値は、current_userのid

ツイートを保存する際、name、image、textというビューから送られてくる情報に加えて、
user_idカラムにログイン中のユーザーのidを保存しなければいけない。
ログイン中のユーザーが持つidを取得するには、current_userメソッドを使用する。


current_userメソッド
Gemのdeviseを導入しているため、使用できるメソッド。
current_userは、現在ログインしているユーザーの情報を取得できる。
現在、ビューから送られてくる情報が入ったparamsと、
current_userメソッドで取得したログイン中ユーザーのidを統合した上で、
ツイートを保存させたいところ。
そこで、2つのハッシュを統合するときに使うmergeメソッドを利用して、
paramsとuser_idの情報を統合できる。

mergeメソッド
ハッシュを結合させるときに使用するRubyのメソッド。
今回は、tweetの情報を持つハッシュと、user_idを持つハッシュを結合さる。
以下の例のように、2つのハッシュを1つにまとめることができる。
【例】
tweet = { name: "たなか", text: "test", image: "test.jpeg" }
uid = { user_id: "1" }
tweet.merge(uid)
=> {:name=>"たなか", :text=>"test", :image=>"test.jpeg", :user_id=>"1"}



アソシエーション
モデル同士を関連付け
ツイートの取得にはTweetモデルを使用し、Tweet.allという記述ができた。
しかし今回のように、ツイートを行なったユーザーの情報を取得するなど、複数のモデルから情報を必要とするケースがある。
複数のモデルで情報を取得しようとすると記述が増え複雑になってしまう。
そこで、テーブル同士で関連付けておき、
一方のモデルからもう一方のモデルにアクセスできるようへするためのアソシエーションという概念がある。

アソシエーションを深ぼる
アソシエーションとは、モデルを利用したテーブル同士の関連付けのこと。
アソシエーションをモデルに定義することで、そのモデルに紐づく別のモデルの情報へアクセスできるようになる。


アソシエーションを定義
has_manyメソッド
Userモデルの視点で考えると、あるユーザーの作成した投稿は複数個ある状態。
つまり、1人のユーザーは複数の投稿を所有している。
この状態のことをhas manyの関係といい、今回の場合は「User has many Tweets」の状態である。
この関連付けをするため、
userと他のモデルとの間に「1対多」のつながりがあることを示すのがhas_manyメソッド。

belongs_toメソッド
1つの投稿は、1人のユーザーが投稿したもの。
つまり1つの投稿を複数人が投稿できないため、投稿は必ず1人のユーザーに所属する。
この状態のことをbelongs toの関係といい、今回の場合は「Tweet belongs to User」の状態である。
Tweetモデルと他のモデル（User）との間に「1対1」のつながりがあることを示すのがbelongs_toメソッド。


※アソシエーションでbelongs_toを指定した場合は、
相手のモデルのid（今回はuser_id）が存在するというバリデーションは不要である。

user_idカラムに対して「空ではないか」というpresence: trueのバリデーションを設ける必要はない。
なぜならアソシエーションでbelongs_toを指定した場合、
相手のモデルのid（今回はuser_id）が「空ではないか」というバリデーションが、
デフォルトでかかるようになっているから。
【例】app/models/tweet.rb
class Tweet < ApplicationRecord
  belongs_to :user
  validates :user_id presence: true ←不要
end

これで、TweetモデルとUserモデル間のアソシエーションが実装できた。



ツイートからユーザー情報も先に読み込む仕組み
N+1問題
N+1問題とは、アソシエーションを利用した場合に限り、データベースへのアクセス回数が多くなってしまう問題。
これはアプリケーションのパフォーマンス低下につながる。
通常、Tweet.allなどでデータを取得する際は、1度のアクセスで済む。
しかし今回のような、ツイートが複数存在する一覧画面に、
それぞれユーザー名を表示するケースを考えてみる。
この場合、tweetsに関連するusersの情報の取得に、ツイート数と同じ回数のアクセスが必要になる。
1億ツイートあれば、1億回以上アクセスすることになり、アプリケーションのパフォーマンスが著しく下がることになる。
これを解決するためには、includesメソッドを利用する。

includesメソッド
includesメソッドは、引数に指定された関連モデルを1度のアクセスでまとめて取得できる。
書き方は、includes(:紐付くモデル名)とします。引数に関連モデルをシンボルで指定する。
【例】
モデル名.includes(:紐付くモデル名)

これにより、N+1問題を解消できる。



tweetsテーブルから不要なカラムを削除
ツイートに「Nickname」という情報を保存しなくなったのでnameカラムも不要になる。
そこで、テーブルからカラムを削除するためのマイグレーションを作成して、カラムの削除を実行する。
のためには、以下のようにコマンドを実行する。
【例】ターミナル
% rails g migration Removeカラム名From削除元テーブル名 削除するカラム名：型

今回は、tweetsテーブルからstring型のnameというカラムを削除する。
tweetsテーブルからnameカラムを削除
ターミナル
# マイグレーションの作成
% rails g migration RemoveNameFromTweets name:string

# マイグレーションの実行
% rails db:migrate

Removeカラム名From削除元テーブル名のカラム名の部分は、
Addカラムの際と同様に必ずしも厳密なカラム名を入力する必要はない。
対して、削除元テーブル名は正確に記述する必要がある！
今回はnameというカラムを削除するので、Nameを含めておく。
末尾のname:stringが、どのカラムを削除するのかを決めているので必ず記述する。

ローカルサーバーを再起動しましょう
カラム情報を変更したため、ローカルサーバーを再起動
ターミナル
# 「control + C」でローカルサーバーを停止

# ローカルサーバーを起動
% rails s



要点チェック
current_userメソッドとは、Gemのdeviseのメソッドで、現在ログインしているユーザーの情報を取得できるメソッドのこと
mergeメソッドとは、ハッシュを結合させるRubyのメソッドのこと
アソシエーションとは、モデルを利用したテーブル同士の関連付けのこと
belongs_toメソッドとは、モデルと他のモデルが「１対１」の関連付けの場合に使用するメソッドで、従属する関連になること
has_manyメソッドとは、モデルと他のモデルが「１対多」の関連付けの場合に使用するメソッドで、所有する関連になること
N+1問題とは、データの取得の際にアクセス過多になってしまう問題のこと
includesメソッドとは、N+1問題を解消できるメソッドのこと


要点チェック
user_signed_in?は、
ユーザーがログインしているか否かを判断できるdeviseが用意しているメソッドのこと

current_userは、
ログインをしているユーザーの情報が取得できるdeviseが用意しているメソッドのこと



ツイートの最新順表示
レコードの取得順を変える。
ツイートを並び替える方法は、
表示のときに順番を変えるのではなく、情報を取得するタイミングで先に並び替える。

orderメソッド
モデルが使用できる、ActiveRecordメソッドの1つ。
orderメソッドは、テーブルから取得してきた複数のレコード情報を持つインスタンスの、並び順を変更するメソッド。
引数には、"並び替えの基準となるカラム名 並び順"のように「並び替えの基準となるカラム名」と「並び順」を半角スペースで繋げて指定する。
orderメソッドは、複数のレコード情報を取得する文に続けて以下のように使用する。
【例】
インスタンス = モデル名.order("並び替えの基準となるカラム名 並び順")

並び順にはそれぞれAscending/Descendingの略でASC（昇順）とDESC（降順）の2種類がある。
並び順        内容
ASC(昇順)     小さいものから大きいものになる。古いものから新しいのものになる
DESC(降順)    ASCの反対

これらのメソッドはコントローラーのアクション内で記述できるメソッド。


要点チェック
orderメソッドとは、ActiveRecordメソッドで、
テーブルから取得してきた複数のレコード情報を持つインスタンスの並び順を変更するメソッドのこと



部分テンプレート
部分テンプレートとは、ビューファイルにおいて繰り返し使用するコードを切り出し、再利用する仕組みのこと。
Rubyでは、繰り返し使うような処理をメソッドとしてまとめていた。これと考え方は同じもの。
複数箇所で使用されている部分に変更があった際でも、1つのファイルの編集だけで済むメリットがある。

今回のアプリ一覧画面では、トップページとマイページでコードが繰り返し使用されている。
Railsでは、繰り返し使用されている部分を_○○.html.erbというファイル名で切り出し、
使用するファイルで割り当てることにより、管理しやすいコードにできる。

_○○.html.erbファイル
部分テンプレートとして切り出すときに作成するファイル。
テンプレート自体のファイル名は、命名規則として、アンダースコア_を先頭に記述する。


_tweet.html.erbファイルが、「ツイート1つ分」のHTML構造を表す部分テンプレートになる。
そのため、複数形のtweetsではなく単数形のtweetになっている点も把握する。
続いて、こちらの部分テンプレートを呼び出すために、renderメソッドを利用する。

renderメソッド
renderメソッドは、部分テンプレートを呼び出す際に利用するメソッド。
呼び出す部分テンプレートは、partialというオプションで指定する。

partialオプション
renderメソッドで使用できるオプション。
partialというオプションを付け、部分テンプレート名を指定することで、該当する部分テンプレートを表示できる。
下の例では、_sample.html.erbという部分テンプレートを呼び出している。
【例】renderメソッドのpartialオプション
# <% render partial: "sample" %>

また、renderメソッドでは、呼び出す部分テンプレートに値を渡すために、localsというオプションを使用できる。

localsオプション
renderメソッドで使用できるオプション。
localsというオプションを付けることで、部分テンプレート内でその変数を使えるようになる。
【例】renderメソッドのlocalsオプション
# <% render partial: "sample", locals: { post: "hello!" } %>

上の記述で、部分テンプレート内においてhello!という文字列の代入されたpostという変数が使えるようになる。


要点チェック
部分テンプレートとは、ビューファイルにおいて繰り返し使用するコードを切り出し、再利用する仕組みのこと
renderメソッドとは、部分テンプレートを呼び出す際に利用するメソッドのこと



コメント機能の実装
コメントは、ツイートが必ず所有する情報ではないため、ツイートと別のテーブルで管理する必要がある。
commentsテーブルを作成。
さらに、コメントはどのツイートに対してのコメントなのか、誰の投稿したコメントなのかが明示されている必要がある。
そのため、userモデルとtweetモデルの2つにアソシエーションを組む必要がある。



ルーティングのネスト
ネストは、ある記述の中に別の記述をして、親子関係を示す方法。「入れ子構造」とも呼ばれる。
ルーティングにおけるネストとは、
あるコントローラーのルーティングの中に、別のコントローラーのルーティングを記述すること。
【例】ルーティングのネスト
Rails.application.routes.draw do
  resources :親となるコントローラー do
    resources :子となるコントローラー
  end
end

ルーティングでネストを利用すると、アクションを実行するためのパスで、親子関係を表現できる。

ルーティングにネストを利用しなければ、
モデルと結びついている別モデルのid情報が送れなくなる。
ネストを利用すれば、id情報を含めることができる。

まとめると、
ルーティングをネストさせる一番の理由は、
アソシエーション先のレコードのidをparamsに追加してコントローラーに送るため。
今回の実装だと、コメントと結びつくツイートのidをparamsに追加する。



検索機能の実装
searchアクションのルーティングを設定
searchという命名で、7つの基本アクション以外のアクションを定義

collectionとmember
collectionとmemberは、ルーティングを設定する際に使用できる。
これを使用すると、生成されるルーティングのURLと実行されるコントローラーを任意にカスタムできる。

collectionはルーティングに:idがつかない、
memberは:idがつくという違いがある。
【例】collectionで定義した場合
Rails.application.routes.draw do
  resources :tweets do
    collection do
      get 'search'
    end
  end
end

【例】collectionのルーティング
Prefix           Verb    URI                                 Pattern
search_tweets    GET    /tweets/search(.:format)              tweets#search

※ルーティングに:idが付いていない

【例】memberで定義した場合
Rails.application.routes.draw do
  resources :tweets do
    member do
      get 'search'
    end
  end
end

【例】memberのルーティング
Prefix           Verb    URI                                 Pattern
search_tweet      GET    /tweets/:id/search(.:format)       tweets#search

URLの指定先が、collectionは:idなし、memberが:idありとなっていることが確認できる。
今回の検索機能の場合、
詳細ページのような:idを指定して特定のページにいく必要がないため、collectionを使用してルーティングを設定する。