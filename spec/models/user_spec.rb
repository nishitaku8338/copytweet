require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail,passwordとpassword_confirmationが存在すれば登録できる' do
        @user.nickname = 'aaaaaa'
        expect(@user).to be_valid
      end
      it 'nicknameが6文字以下であれば登録できる' do
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        # nicknameが空では登録できないテストコードを記述します
        # nicknameの値が空のインスタンスを生成
        # user = User.new(nickname: '', email: 'test@example', password: '000000', password_confirmation: '000000')
        # user = FactoryBot.build(:user)  # Userのインスタンス生成
        # user.nickname = ''  # nicknameの値を空にする
        # user.valid?
        # expect(user.errors.full_messages).to include("Nickname can't be blank")
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        # emailが空では登録できないテストコードを記述します
        # user = User.new(nickname: 'test', email: '', password: '000000', password_confirmation: '000000')
        # user = FactoryBot.build(:user)  # Userのインスタンスを生成
        # user.email = ''  # emailの値を空にする
        # user.valid?
        # expect(user.errors.full_messages).to include("Email can't be blank")
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'nicknameが7文字以上では登録できない' do
        @user.nickname = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Nickname is too long (maximum is 6 characters)')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
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

# nicknameの値が空のインスタンスを生成
# nicknameに設定されているpresence: tureが正常に機能するか検証するため、
# バリデーションを実行します。バリデーションはDBに保存する前しか実行されません。
# そこで、valid?メソッドを用いて、任意のタイミングでバリデーションを実行しましょう。


# valid?
# valid?は、バリデーションを実行させて、エラーがあるかどうかを判断するメソッド。
# エラーがない場合はtrueを、ある場合はfalseを返します。
# また、エラーがあると判断された場合は、エラーの内容を示すエラーメッセージを生成。

# nicknameが空のインスタンスuserに、valid?メソッドを使用しています。
# Userモデルのバリデーションにはpresence: trueが指定されているため、
# nicknameが空ではDBに保存できないと判断され、valid?メソッドはfalseを返すはずです。

# 上記のような「想定した挙動」と「アプリの実際の挙動」を確認します。
# この確認をテストコードに落とし込んだものをexpectationといいます。

# expectation（エクスペクテーション）
# エクスペクテーションとは、検証で得られた挙動が想定通りなのかを確認する構文のこと。
# expect().to matcher()を雛形に、テストの内容に応じて引数やmatcherを変えて記述します。

# matcher（マッチャ）
# matcherは、「expectの引数」と「想定した挙動」が一致しているかどうかを判断します。
# expectの引数には検証で得られた実際の挙動を指定し、マッチャには、どのような挙動を想定しているかを記述します。

# 代表的な2つのincludeとeqマッチャを紹介します。

# include
# includeは、「expectの引数」に「includeの引数」が含まれていることを確認するマッチャです。

# 具体的には、以下のように記述します。

# 【例】includeマッチャのテストコード
# describe 'フルーツ盛り合わせ' do
#   it 'フルーツ盛り合わせにメロンが含まれている' do
#     expect(['りんご', 'バナナ', 'ぶどう', 'メロン']).to include('メロン')
#   end
# end

# このように記述することで、
# りんご、バナナ、ぶどう、メロンが入った配列に、メロンが含まれることを想定しています。

# このテストコードを実行した場合、
# 想定通り配列のなかにメロンは含まれているため、テストは成功します。

# eq
# eqは、「expectの引数」と「eqの引数」が等しいことを確認するマッチャです。
# 具体的には、以下のように記述します。

# 【例】eqマッチャのテストコード
# describe '加算' do
#   it '1 + 1の計算結果は2と等しい' do
#     expect(1 + 1).to eq(2)
#   end
# end

# このように記述することで、1 + 1という計算の結果が、2と等しいことを想定しています。
# このテストコードを実行した場合、想定通り1 + 1は2と等しいため、テストは成功します。
# 以上の例をふまえて、今回行っているテストのエクスペクテーションを考えましょう。

# Userモデルで、nicknameにはpresence: trueのバリデーションを設けています。
# このバリデーションが正しく機能していれば、
# valid?メソッドを実行したときにfalseが返ってくるはずです。
# falseが返ってくるということはDBに保存できないと判断されたため、
# インスタンスにはエラーの内容を示す情報が生成されます。
# errorsメソッドを用いてエラーの内容を確認してみましょう。

# errors
# errorsは、インスタンスにエラーを示す情報がある場合、その内容を返すメソッド。

# full_messages
# full_messagesは、エラーの内容から、エラーメッセージを配列として取り出すメソッドです。

# ターミナルでuser.errors.full_messagesと実行すると、以下のようにエラーの内容の配列が返されます。

# 【例】ターミナル
# # 上記の例に続けて以下を実行すると、エラーメッセージが表示される
# [4] pry(main)> user.errors.full_messages
# => ["Nickname can't be blank"]

# 以上のことをふまえて、どのようなエクスペクテーションを記述すればよいのか考えます。

# expectの引数には検証で得られた挙動を指定したいため、valid?メソッドを使用した後のインスタンスのエラーメッセージを指定しましょう。
# すなわち、expect(user.errors.full_messages)となります。

# さらに、full_messagesの返り値は配列であるため、includeマッチャを用いて、
# 配列にどのようなエラーが含まれていればよいか指定します。

# nicknameでpresence: trueによるエラーが起こるはずであるため、
# 想定するエラーメッセージは"Nickname can't be blank"が適切です。

# be_valid
# be_validとは、valid?メソッドの返り値が、trueであることを期待するマッチャ
# expectの引数に指定されたインスタンスが、
# バリデーションでエラーにならないものであれば、valid?の返り値はtrueとなりテストは成功

# context
# contextは、特定の条件を指定してグループを分けます。
# 使用方法はdescribeと同じですが、
# describeには何についてのテストなのかを指定するのに対し、contextには特定の条件を指定します。