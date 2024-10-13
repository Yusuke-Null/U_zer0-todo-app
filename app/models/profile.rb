class Profile < ApplicationRecord
  has_one_attached :avatar
  belongs_to :user

  enum genders:{male: 0, female: 1, other: 2}

  def get_genders
    Profile.genders.keys.map {|k| [I18n.t("enum.genders.#{k}"), k]}
  end
end
