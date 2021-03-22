class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      # t.integer :user_id   # 誰が投稿したのか
      t.references :user,   foreign_key: true
      
      # t.integer :tweet_id  # どの投稿なのか
      t.references :tweet,  foreign_key: true
      
      t.text :text           # コメントの内容
      t.timestamps
    end
  end
end


# コメントの本文は、textカラムに保存する。
# 注意する点
# カラムにuser_idとtweet_idがあること。
# コメントはまず「誰が投稿したコメントなのか」がわかる必要があるので、
# 結びつくユーザーのidを保存する必要がある。
# 今回は、そのidを保存するカラム名をuser_idとする。
# ※一般的には、t.references :user,   foreign_key: true

# さらに、コメントは「どのツイートに対してのコメントなのか」を明示する必要がある。
# 結びつくツイートのidを保存するカラムは、tweet_idとする。
# ※一般的には、t.references :tweet,  foreign_key: true

# マイグレーションの記述が完成したら、rails db:migrateを実行してテーブルを作る。