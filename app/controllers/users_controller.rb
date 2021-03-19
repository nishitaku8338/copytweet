class UsersController < ApplicationController
  
  # ユーザーマイページのコントローラーshowアクションを定義
  def show
    # 現在ログインしているユーザーが持つnicknameカラムの値を取得
    @nickname = current_user.nickname
    # 現在ログインしているユーザーのツイート投稿を取得して、インスタンス変数に代入
    @tweets = current_user.tweets
  end

end

# showアクションで表示するのは、ログイン中ユーザーのマイページとなるため、
# 必要な情報は「ニックネーム」と「ログイン中のユーザーのツイート投稿」の2つ
# それぞれを@nicknameと@tweetsというインスタンス変数に代入する
# @nicknameはcurrent_userを利用し、現在ログインしているユーザーが持つnicknameカラムの値を取得
# @tweetsも現在ログインしているユーザーのツイート投稿を取得して、インスタンス変数に代入