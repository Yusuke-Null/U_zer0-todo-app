class Task < ApplicationRecord
  has_one_attached :eyecatch
  has_many :comments
  belongs_to :user
  belongs_to :board

  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true

  def has_comment?(task_id)
    comments = Comment.where(task_id: task_id)
    0 < comments.count ? true : false
  end
end
