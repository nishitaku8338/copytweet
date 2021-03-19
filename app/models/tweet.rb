class Tweet < ApplicationRecord
  validates :text, presence: true  # 空のツイートは登録できない。

  belongs_to :user  # アソシエーション(1対1)
end
