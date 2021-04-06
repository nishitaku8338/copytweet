require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      # nicknameが空では登録できないテストコードを記述します
      # nicknameの値が空のインスタンスを生成
      user = User.new(nickname: '', email: 'test@example', password: '000000', password_confirmation: '000000')
    end
    it 'emailが空では登録できない' do
      # emailが空では登録できないテストコードを記述します
    end
  end
end


# テストコードを実行
# % bundle exec rspec spec/models/user_spec.rb


# rails_helper
# Rspecを用いてRailsの機能をテストするときに、共通の設定を書いておくファイル。
# 各テスト用ファイルでspec/rails_helper.rbを読み込むことで、共通の設定やメソッドを適用する。

# describe（ディスクライブ）
# テストコードのグループ分けを行うメソッド。
# 「どの機能に対してのテストを行うか」をdescribeでグループ分けし、その中に各テストコードを記述する。
# describeにつづくdo~endの間に、さらにdescribeメソッドを記述することで、入れ子構造をとることもできる。

# it（イット）
# itメソッドは、describeメソッド同様に、グループ分けを行うメソッド。
# itの場合はより詳細に、「describeメソッドに記述した機能において、どのような状況のテストを行うか」を明記する。
# itメソッドで分けたグループを、exampleとも呼ぶ。

# example（イグザンプル）
# exampleとは、itで分けたグループのことを指す。
# また、itに記述した内容のことを指す場合もある。

# テストコードを実行するときには、bundle execコマンドに続けて、rspecコマンドを入力して実行

# bundle exec
# Gemの依存関係を整理してくれるコマンド
# RSpecをはじめ、多くのGemはその他のGemと関係があり、互いに依存している。
# したがって、bundle execコマンドを用いてGemの依存関係を整理する必要がある。

# rspec
# specディレクトリ以下に書かれたRSpecのテストコードを実行するコマンド。
# 実行するファイルを指定することも可能。



# nicknameが空の場合の記述
# 異常系のモデル単体テストの実装は、以下の流れで進み
# 1,保存するデータ（インスタンス）を作成する
# 2,作成したデータ（インスタンス）が、保存されるかどうかを確認する
# 3,保存されない場合、生成されるエラーメッセージが想定されるものかどうかを確認する
# nicknameとemailのテスト実装を通して、この流れを理解

nicknameの値が空のインスタンスを生成
nicknameに設定されているpresence: tureが正常に機能するか検証するため、
バリデーションを実行します。バリデーションはDBに保存する前しか実行されません。
そこで、valid?メソッドを用いて、任意のタイミングでバリデーションを実行しましょう。


valid?
valid?は、バリデーションを実行させて、エラーがあるかどうかを判断するメソッド。
エラーがない場合はtrueを、ある場合はfalseを返します。
また、エラーがあると判断された場合は、エラーの内容を示すエラーメッセージを生成。