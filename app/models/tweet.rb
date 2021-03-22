class Tweet < ApplicationRecord
  validates :text, presence: true  # 空のツイートは登録できない。

  belongs_to :user    # usersテーブルとのアソシエーション(1対1)
  has_many :comments  # commentsテーブルとのアソシエーション
end


# ツイートは、複数のコメントを所有することができるので、
# has_many :モデル複数形と記述することで、アソシエーションを組む。