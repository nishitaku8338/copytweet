class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]  # set_tweetというメソッドを定義して、同じコードをメソッドにまとめる

  def index
    @tweets = Tweet.all  # データベースに保存されているすべてのデータを取得
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
  end

  private
  # tweet_paramsというストロングパラメーターを定義し、createメソッド・updateメソッドの引数に使用して、tweetsテーブルへ保存
  def tweet_params
    params.require(:tweet).permit(:name, :image, :text)  # require(モデル名)、permit(カラム名)。カラム名はマイグレーションファイルを参照する
  end

  # set_tweetというメソッドを定義して、editアクション・showアクションの同じコードをまとめる
  def set_tweet
    @tweet = Tweet.find(params[:id])  # 単一レコードを取得
  end
end
