class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boards
  has_one :profile, dependent: :destroy

  def has_profile?
    build_profile || self.profile
  end

  def has_avatar?

  end
  # delegate :user, to: :profile, allow_nil: true
end
