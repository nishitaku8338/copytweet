class Comment < ApplicationRecord
  belongs_to :tweet  # tweetsテーブルとのアソシエーション
  belongs_to :user   # usersテーブルとのアソシエーション
end


# コメントは、1人のユーザーと1つのツイートに所属するので、
# belongs_to :モデル単数形と記述することで、アソシエーションを定義する。