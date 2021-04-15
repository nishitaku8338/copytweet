class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :tweets    # tweetsテーブルとのアソシエーション(1対多)
  has_many :comments  # commentsテーブルとのアソシエーション

  # バリデーション
  # validates :nickname, presence: true
  # 「保存できる値は最大6文字まで」というバリデーションを設置
  validates :nickname, presence: true, length: { maximum: 6 }
end


# ユーザーは、複数のコメントを投稿することができるので、
# has_many :モデル複数形と記述することで、アソシエーションを組む。