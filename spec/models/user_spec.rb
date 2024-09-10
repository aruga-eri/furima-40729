require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "新規登録ができる場合" do
      it "すべての入力が存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "パスワードが6文字以上、半角英数であれば登録できる" do
        @user.password = "123abc"
        @user.password_confirmation = "123abc"
        expect(@user).to be_valid
      end
      it "名字が全角（漢字・ひらがな・カタカナ）であれば登録できる" do
        @user.last_name = "山田"
        expect(@user).to be_valid
      end
      it "名前が全角（漢字・ひらがな・カタカナ）であれば登録できる" do
        @user.first_name = "陸太郎"
        expect(@user).to be_valid
      end
      it "名字のフリガナが全角（カタカナ）であれば登録できる" do
        @user.last_name_kana = "ヤマダ"
        expect(@user).to be_valid
      end
      it "名前のフリガナが全角（カタカナ）であれば登録できる" do
        @user.first_name_kana = "リクタロウ"
        expect(@user).to be_valid
      end
    end

    context "新規登録できない場合" do
      it "nicknameが空だと登録できない" do  
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空だと登録できない" do  
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "emailに@が含まれていないと登録できない" do
        @user.email = 'invalid_email'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "emailが既に登録しているユーザーと重複していると保存できない" do  
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "パスワードが空だと登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "パスワードは半角英数字混合でないと登録できない（数字のみ）" do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
      end
      it "パスワードは半角英数字混合でないと登録できない(英字のみ)" do 
        @user.password = "abcdef"
        @user.password_confirmation = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
      end
      it "パスワードが5文字以下だと登録できない" do
        @user.password = "abc12"
        @user.password_confirmation = "abc12"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "パスワードが全角では登録できない" do
        @user.password = "１２３４５６"
        @user.password_confirmation = "１２３４５６"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
      end
      it "パスワード（確認）が空だと登録できない" do 
        @user.password = "123456"
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "名字が空だと登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "名字が全角（漢字・ひらがな・カタカナ）でないと登録できない" do  
        @user.last_name = "yamada"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it "名前が空だと登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "名前が全角（漢字・ひらがな・カタカナ）でないと登録できない" do 
        @user.first_name = "rikutaro"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it "名字のフリガナが空だと登録できない" do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it "名字のフリガナが全角（カタカナ）でないと登録できない" do 
        @user.last_name_kana = "やまだ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it "名前のフリガナが空だと登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it "名前のフリガナが全角（カタカナ）でないと登録できない" do
        @user.first_name_kana = "りくたろう"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it "生年月日が空だと登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end





