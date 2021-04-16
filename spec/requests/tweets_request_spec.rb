require 'rails_helper'
describe TweetsController, type: :request do

  before do
    @tweet = FactoryBot.create(:tweet)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
      get root_path
      expect(response.body).to include(@tweet.text)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do 
      get root_path
      expect(response.body).to include(@tweet.image)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do 
      get root_path
      expect(response.body).to include('投稿を検索する')
    end
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get tweet_path(@tweet)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
      get tweet_path(@tweet)
      expect(response.body).to include(@tweet.text)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do 
      get tweet_path(@tweet)
      expect(response.body).to include(@tweet.text)
    end
    it 'showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する' do 
      get tweet_path(@tweet)
      expect(response.body).to include('＜コメント一覧＞')
    end
  end

end

# bundle exec rspec spec/requests/tweets_request_spec.rb

# create
# ActiveRecordのcreateメソッドと同様の意味を持ちます。
# buildとほぼ同じ働きをしますが、createの場合はテスト用のDBに値が保存されます。
# 注意すべき点として、1回のテストが実行され、終了する毎にテスト用のDBの内容がロールバックされます。（保存された値がすべて消去されてしまう）

# status
# response.statusと実行することによって、そのレスポンスのステータスコードを出力でき

# body
# response.bodyと記述すると、ブラウザに表示されるHTMLの情報を抜き出すことができます。