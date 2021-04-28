class Tweet < ApplicationRecord
  # imageも空で投稿できないように追記
  validates :text, :image, presence: true  # 空のツイートは登録できない。

  belongs_to :user    # usersテーブルとのアソシエーション(1対1)
  has_many :comments  # commentsテーブルとのアソシエーション

  # 検索機能
  def self.search(search)  # 引数のsearchは、検索フォームから送信されたパラメーターが入る
    if search != ""        # if search != ""と記述し、検索フォームに何か値が入力されていた場合を条件としている
      Tweet.where('text LIKE(?)', "%#{search}%")  # searchが含まれているテキストを取得
    else
      # 検索フォームからから何も入力せずに検索ボタンを押した場合
      Tweet.all  # Tweetsテーブルのデータを一覧表示する
    end
  end
end


# ツイートは、複数のコメントを所有することができるので、
# has_many :モデル複数形と記述することで、アソシエーションを組む。

# 検索機能
# 引数のsearchは、検索フォームから送信されたパラメーターが入るため、
# if search != ""と記述し、検索フォームに何か値が入力されていた場合を条件としている。

# もし検索フォームに何も入力をせずに検索ボタンを押すと、引数で渡されるsearchの中身は空になる。
# この場合はelseに該当し、Tweet.allという記述は、そのときすべての投稿を取得して表示するためのもの。
# テーブルとのやりとりに関するメソッドはモデルに置くという意識が必要。
# コントローラーはあくまでモデルの機能を利用し処理を呼ぶだけで、複雑な処理は組まない。