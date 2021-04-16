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
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do 
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do 
    end
  end

end

# bundle exec rspec spec/requests/tweets_request_spec.rb

# create
# ActiveRecordのcreateメソッドと同様の意味を持ちます。
# buildとほぼ同じ働きをしますが、createの場合はテスト用のDBに値が保存されます。
# 注意すべき点として、1回のテストが実行され、終了する毎にテスト用のDBの内容がロールバックされます。（保存された値がすべて消去されてしまう）