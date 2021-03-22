Rails.application.routes.draw do
  # deviseをインストールすると勝手に追加される
  devise_for :users

  # ローカルホスト3000の表示するページ
  root to: 'tweets#index'  # http://localhost:3000/

  # ツイートのルーティングを設定
  # resources :tweets, only: [:index, :new, :create, :destroy, :edit, :update, :show]  # http://localhost:3000/tweets/new tweetsコントローラーのnewアクションが実行される設定
  # resources :tweets   # resourcesは、7つのアクションをまとめてルーティングの設定ができる
  resources :tweets do  # ネストを利用したルーティングを設定
    resources :comments, only: :create  # 今回は「コメントを投稿する」機能、つまり「コメント情報を作る機能」を実装するのでcreateアクションのルーティングとする。
  end

  # ユーザーのルーティングを設定
  resources :users, only: :show  # ユーザーのマイページはshowアクションを動かす
end

# updateアクションにはPATCHというHTTPメソッドが使用される
# tweetsコントローラーのshowアクション・destroyアクションへのPrefixはtweet_pathである。
# rails routesを実行すると、showアクション・destroyアクションは同じPrefixのパスである。
# それを見分けるために、link_toメソッドなどでリンクを設定する際には、HTTPメソッドを指定する。

# doとendで挟むことにより、ルーティングの記述をネストさせることができる。
# 「あるツイートに対してのコメント」という親子関係を表現したパスが、コメント投稿に必要なリクエストのパスになる。