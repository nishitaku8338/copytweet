FactoryBot.define do
  factory :user do
    nickname {'test'}
    email {'test@example'}
    password {'000000'}
    password_confirmation {password}
  end
end

# 設定したインスタンスを生成するためには
# FactoryBot.build(:user)
# という記述をテストコードの中に記述する

# build
# ActiveRecordのnewメソッドと同様の意味を持つ。
# 【例】
# FactoryBotを利用しない場合
# user = User.new(nickname: 'test', email: 'test@example', password: '000000', password_confirmation: '00000000')
# FactoryBotを利用する場合
# user = FactoryBot.build(:user)