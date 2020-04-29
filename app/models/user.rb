class User < ApplicationRecord
  before_validation { email.downcase! }
  before_update :must_not_destroy_last_admin_user
  before_destroy :must_not_destroy_last_admin_user

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness:true,
            length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password
  has_many :tasks, dependent: :destroy

  private
  def must_not_destroy_last_admin_user
    user = User.find(id)
    if user.admin? && User.where(admin:true).count == 1
      errors.add(:base, '管理者権限は変更できません。少なくとも1人の管理者は必要です。')
      throw :abort
    end
  end
end