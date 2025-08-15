class User < ApplicationRecord
  # Deviseモジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  # ニックネーム
  validates :nickname, presence: { message: "can't be blank" }

  # お名前（漢字・ひらがな・カタカナ）
  validates :firstname_kanji, presence: { message: "can't be blank" },
                              format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }
  validates :lastname_kanji, presence: { message: "can't be blank" },
                             format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }

  # お名前カナ（全角カタカナ）
  validates :firstname_katakana, presence: { message: "can't be blank" },
                                 format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :lastname_katakana, presence: { message: "can't be blank" },
                                format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }

  # 生年月日
  validates :birth_day, presence: { message: "can't be blank" }

  # パスワード（半角英数字混合・6文字以上）
  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i,
                      message: 'is invalid. Include both letters and numbers' },
            if: -> { password.present? }
end
