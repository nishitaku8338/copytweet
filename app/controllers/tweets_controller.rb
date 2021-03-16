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
    tweet = Tweet.find(params[:id])  # 削除したいツイートをfindメソッドを用いて取得
    tweet.destroy                    # ツイートをdestroyメソッドで削除
  end

  private
  # tweet_paramsというストロングパラメーターを定義し、createメソッドの引数に使用して、tweetsテーブルへ保存
  def tweet_params
    params.require(:tweet).permit(:name, :image, :text)
  end
end
