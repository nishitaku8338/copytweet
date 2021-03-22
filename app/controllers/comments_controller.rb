class CommentsController < ApplicationController
  def create
    # ストロングパラメーターを用いて保存できるカラムを指定
    comment = Comment.create(comment_params)
    redirect_to tweet_path(comment.tweet.id)
    # redirect_to "/tweets/#{comment.tweet.id}"    # コメントと結びつくツイートの詳細画面に遷移する
    # redirect_back(fallback_location: root_path)  # コメントしたらコメントしたページに遷移する
  end

  private

  # ストロングパラメーター
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end

# 渡されたparamsの中にcommentというハッシュがある二重構造になっているため、
# requireメソッドの引数に指定して、textを取り出す。
# user_idカラムには、ログインしているユーザーのidとなるcurrent_user.idを保存し、
# tweet_idカラムは、paramsで渡されるようにするので、params[:tweet_id]として保存している。

# コメントをしたらツイートの詳細画面に戻る処理を、
# redirect_toメソッドを使って画面遷移を記述する。
# redirect_toの後には、ルーティングのURLやPrefixを記述することで、そのアクションを実行できる。
# tweetsコントローラーのshowアクションを実行するには、ツイートのidが必要。
# そのため、ストロングパラメーターを用いた上で変数commentに代入する。
# リダイレクト先の指定には、アソシエーションを利用して、commentと結びつくツイートのidを記述する。