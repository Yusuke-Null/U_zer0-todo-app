class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boards
  has_many :tasks
  has_one :profile, dependent: :destroy

  def prepare_profile
    profile || build_profile
  end

  def has_avatar?(user_id)
    default_image = 'default-avatar.png'
    return default_image if isExisted(user_id)
    return default_image if user_has_profile?
    @user.profile.avatar.nil? ? default_image : @user.profile.avatar
  end

  def has_nickname?(user_id)
    return 'Deleted user' if isExisted(user_id)
    return @user.email if user_has_profile?
    @user.profile.nickname.blank? ? @user.email : @user.profile.nickname
  end

  private
  def isExisted(user_id)
    @user = User.find_by(id: user_id)
    @user.nil?
  end

  def user_has_profile?
    @user.profile.blank?
  end
end
