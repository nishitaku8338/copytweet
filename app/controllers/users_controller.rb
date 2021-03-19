class UsersController < ApplicationController
  
  # ユーザーマイページのコントローラーshowアクションを定義
  def show
    # クリックされたユーザーのidから情報を取得して、ビューに受け渡す
    # 変数を利用して、各インスタンス変数ではcurrent_userを変数userに変更
    user = User.find(params[:id])  # 注1 送られたidをparamsで取得し、そのユーザーのレコードを変数userに代入
    @nickname = user.nickname      # ユーザーのnicknameを取得
    @tweets = user.tweets          # ユーザーが投稿したツイートを取得

    # 現在ログインしているユーザーが持つnicknameカラムの値を取得
    # @nickname = current_user.nickname
    # 現在ログインしているユーザーのツイート投稿を取得して、インスタンス変数に代入
    # @tweets = current_user.tweets
  end

end

# showアクションで表示するのは、ログイン中ユーザーのマイページとなるため、
# 必要な情報は「ニックネーム」と「ログイン中のユーザーのツイート投稿」の2つ
# それぞれを@nicknameと@tweetsというインスタンス変数に代入する
# @nicknameはcurrent_userを利用し、現在ログインしているユーザーが持つnicknameカラムの値を取得
# @tweetsも現在ログインしているユーザーのツイート投稿を取得して、インスタンス変数に代入

# 注1
# ツイートの右下に表示されるユーザー名をクリックすることで、送られたidをparamsで取得し、そのユーザーのレコードを変数userに代入している。
# この変数を利用して、各インスタンス変数ではcurrent_userを変数userに変更する。
# その上で、@nicknameでは、ユーザーのnicknameを取り出している。
# アソシエーションを利用しuser.tweetsとすることで、そのユーザーが投稿したツイートを取得して、@tweetsに代入している。