Rails.application.routes.draw do
  root to: 'tweets#index'                  # http://localhost:3000/
  resources :tweets, only: [:index, :new]  # http://localhost:3000/tweets/new tweetsコントローラーのnewアクションが実行される設定
end
