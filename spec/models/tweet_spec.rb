require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end

  describe 'ツイートの保存' do
    context 'ツイートが投稿できる場合' do
      it '画像とテキストがあれば投稿できる' do
        expect(@tweet).to be_valid
      end
      # バリデーションの変更⇢imageがないと保存できないになった為、下記をコメントアウト。
      # it 'テキストがあれば投稿できる' do
      #   @tweet.image = ''
      #   expect(@tweet).to be_valid
      # end
    end
    context 'ツイートが投稿できない場合' do
      it 'テキストが空では投稿できない' do
        @tweet.text = ''
        @tweet.valid?
        # expect(@tweet.errors.full_messages).to include("Text can't be blank")
        expect(@tweet.errors.full_messages).to include('テキストを入力してください')
      end
      # バリデーションの変更⇢imageがないと保存できないになった為、下記を追加。
      it '画像がないとツイートは保存できない' do
        @tweet.image = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('画像を入力してください')
      end     
      it 'ユーザーが紐付いていなければ投稿できない' do
        @tweet.user = nil
        @tweet.valid?
        # expect(@tweet.errors.full_messages).to include('User must exist')
        expect(@tweet.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end

# bundle exec rspec spec/models/tweet_spec.rb

# expect(@tweet.errors.full_messages).to include('Userを入力してください')のUserは今回ja.ymlに記述してないので、
# Userのままで問題ない。