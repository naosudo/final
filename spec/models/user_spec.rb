require 'rails_helper'

describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nicknameとemail、passwordとpassword_confirmationとfirstname_kanjiとlastname_kanjiとfirstname_katakanaとlastname_katakanaとbirth_dayが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上であれば登録できる' do
        @user.password = 'aaa000'
        @user.password_confirmation = 'aaa000'
        expect(@user).to be_valid
      end

      it 'passwordとpassword_confirmationが同じなら登録できる' do
        @user.password = @user.password_confirmation
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailに@が含まれていなければ登録できない' do
        @user.email = 'aaaaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'aaa00'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordに半角英字がなければ登録できない' do
        @user.password = '000000'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordに半角数字がなければ登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordに全角文字があれば登録できない' do
        @user.password = 'ａｂｃ123'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordとpassword_confirmationが一致しなければ登録できない' do
        @user.password = 'aaa000'
        @user.password_confirmation = 'aaa111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'firstname_kanjiが存在しなければ登録できない' do
        @user.firstname_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname kanji can't be blank")
      end

      it 'lastname_kanjiが存在しなければ登録できない' do
        @user.lastname_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname kanji can't be blank")
      end

      it 'firstname_katakanaが存在しなければ登録できない' do
        @user.firstname_katakana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname katakana can't be blank")
      end

      it 'lastname_katakanaが存在しなければ登録できない' do
        @user.lastname_katakana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname katakana can't be blank")
      end

      it 'firstname_kanjiが全角入力でなければ登録できない' do
        @user.firstname_kanji = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname kanji is invalid. Input full-width characters')
      end

      it 'lastname_kanjiが全角入力でなければ登録できない' do
        @user.lastname_kanji = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Lastname kanji is invalid. Input full-width characters')
      end

      it 'firstname_katakanaが全角カタカナ入力でなければ登録できない' do
        @user.firstname_katakana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname katakana is invalid. Input full-width katakana characters')
      end

      it 'lastname_katakanaが全角カタカナ入力でなければ登録できない' do
        @user.lastname_katakana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Lastname katakana is invalid. Input full-width katakana characters')
      end

      it 'birth_dayが存在しなければ登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end
end
