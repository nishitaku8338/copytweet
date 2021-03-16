Rails.application.routes.draw do
  root to: 'tweets#index'                  # http://localhost:3000/
  # resources :tweets, only: [:index, :new, :create, :destroy, :edit, :update, :show]  # http://localhost:3000/tweets/new tweetsコントローラーのnewアクションが実行される設定
  resources :tweets  # resourcesは、7つのアクションをまとめてルーティングの設定ができる
end

# updateアクションにはPATCHというHTTPメソッドが使用される
# tweetsコントローラーのshowアクション・destroyアクションへのPrefixはtweet_pathである。
# rails routesを実行すると、showアクション・destroyアクションは同じPrefixのパスである。
# それを見分けるために、link_toメソッドなどでリンクを設定する際には、HTTPメソッドを指定する