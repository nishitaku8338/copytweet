class TweetsController < ApplicationController
  # set_tweetというメソッドを定義して、同じコードをメソッドにまとめる
  before_action :set_tweet, only: [:edit, :show]

  # ログイン状態によって、遷移できるページを制限する
  # indexアクション・showアクションは適用されない
  # before_action :move_to_index, except: [:index, :show]
  before_action :move_to_index, except: [:index, :show, :search]  # ※2 serachを追加

  def index
    # @tweets = Tweet.all  # データベースに保存されているすべてのデータを取得
    # includesメソッドを使用してN+1問題を解消
    # @tweets = Tweet.includes(:user)  # includesメソッドを使用するとすべてのレコードを取得
    @tweets = Tweet.includes(:user).order("created_at DESC")  # レコードは降順に並び替え(新しいツイートが上に表示される)
  end

  def new
    @tweet = Tweet.new  # インスタンスを生成
  end

  def create
    Tweet.create(tweet_params)  # tweet_paramsというストロングパラメーターを定義
  end

  def destroy
    # ビューファイルにインスタンス変数を使用しないので「@」を使わない
    tweet = Tweet.find(params[:id])  # 削除したいツイートをfindメソッドを用いて取得
    tweet.destroy                    # ツイートをdestroyメソッドで削除
  end

  def edit
    # @tweet = Tweet.find(params[:id])  # 編集したいツイートをfindメソッドを用いて取得、form_withのmodelオプション(引数)に使う
  end

  def update
    # ビューファイルにインスタンス変数を使用しないので「@」を使わない
    tweet = Tweet.find(params[:id])  # 編集したいツイートをfindメソッドを用いて取得
    tweet.update(tweet_params)       # tweet_paramsというストロングパラメーターを定義
  end

  def show
    # @tweet = Tweet.find(params[:id])  # ツイート詳細画面に必要な情報を、findメソッドを用いてデータベースから取得
    
    # コメント機能：tweets/show.html.erbでform_withを使用して、
    # comments#createを実行するリクエストを飛ばしたいので、@comment = Comment.newというインスタンス変数を生成する。
    @comment = Comment.new

    # tweetsテーブルとcommentsテーブルはアソシエーションが組まれているので、
    # @tweet.commentsとすることで、@tweetへ投稿されたすべてのコメントを取得できる。
    # また、ビューでは誰のコメントか明らかにするため、
    # アソシエーションを使ってユーザーのレコードを取得する処理を繰り返す。
    # そのときに「N+1問題」が発生してしまうので、includesメソッドを使って、N+1問題を解決
    @comments = @tweet.comments.includes(:user)
  end

  # 7つのアクション以外のアクション
  def search  # Tweetモデルに書いたsearchメソッドを呼び出
    # searchメソッドの引数にparams[:keyword]と記述して、検索結果を渡す
    @tweets = Tweet.search(params[:keyword])
  end

  private
  # tweet_paramsというストロングパラメーターを定義し、createメソッド・updateメソッドの引数に使用して、tweetsテーブルへ保存
  # require(モデル名)、permit(カラム名)。カラム名はマイグレーションファイルを参照する
  # current_userメソッドはdeviseのメソッド。現在ログインしているユーザーの情報を取得できる
  # mergeメソッドでtweetの情報を持つハッシュと、user_idを持つハッシュを結合させる
  def tweet_params
    # params.require(:tweet).permit(:name, :image, :text).merge(user_id: current_user.id)  # ※1
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  # set_tweetというメソッドを定義して、editアクション・showアクションの同じコードをまとめる
  def set_tweet
    @tweet = Tweet.find(params[:id])  # 単一レコードを取得
  end

  # ログインしていない状態で新規投稿画面へ直接アクセスした場合、indexアクションのindex.html.erbページにリダイレクトする。
  def move_to_index
    unless user_signed_in?  # unlessでuser_signed_in?を判定(userがログインしているか)
      redirect_to action: :index  # その返り値がfalseだった場合にredirect_toが実行される。
    end
  end
end

# ※1
# 投稿時に「name」を入力する必要がなくなったので、それに合わせてtweetsコントローラーの処理も変更
# nameカラムはもう使用しないので、ツイートの保存時にnameカラムへ情報を保存しないよう変更
# permit(:name, :image, :text)から:nameを削除

# ※2
# 未ログイン時に検索をするとトップページへリダイレクトされる。
# これを回避するために、before_actionのexceptオプションに:searchを追加