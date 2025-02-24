class User < ApplicationRecord
  # has_secure_password：
  # - ハッシュ化したパスワードを、DB内のpassword_digestというカラムに保存できるようになる
  # - 2つのペアの仮想的なカラム？（passwordとpassword_confirmation）が使えるようになり、それとDBに保存されている値が一致するかどうかのバリデーションも使えるようになる
  # - 条件として、password_digestというカラムがDB内に含まれている必要がある
  has_secure_password validations: true

  validates :user_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum:4 }#, if: -> { new_record? || changes[:password_digest] }
  validates :password_confirmation, presence: true, length: { minimum:4 }#, if: -> { new_record? || changes[:password_digest] }
end