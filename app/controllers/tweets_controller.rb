class TweetsController < ApplicationController
  
  def index
    @tweets = Tweet.all
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
    @tweet = Tweet.find(params[:id])  # 編集したいツイートをfindメソッドを用いて取得、form_withのmodelオプション(引数)に使う
  end

  def update
    # ビューファイルにインスタンス変数を使用しないので「@」を使わない
    tweet = Tweet.find(params[:id])  # 編集したいツイートをfindメソッドを用いて取得
    tweet.update(tweet_params)       # tweet_paramsというストロングパラメーターを定義
  end

  private
  # tweet_paramsというストロングパラメーターを定義し、createメソッド・updateメソッドの引数に使用して、tweetsテーブルへ保存
  def tweet_params
    params.require(:tweet).permit(:name, :image, :text)
  end
end
