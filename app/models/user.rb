class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :tweets    # tweetsテーブルとのアソシエーション(1対多)
  has_many :comments  # commentsテーブルとのアソシエーション

  # バリデーション
  validates: nickname, presence: true
end


# ユーザーは、複数のコメントを投稿することができるので、
# has_many :モデル複数形と記述することで、アソシエーションを組む。