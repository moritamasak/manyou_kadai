class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  scope :name_search,  -> (name) {where('name LIKE ?',"%#{name}%")}
  scope :status_search, -> (status) {where(status: status)}
  scope :label_search, -> (label) {where(id: Labeling.where(label_id: label).select(:task_id))}
  enum status:{未着手:0,着手中:1,完了:2}
  enum priority:{高:0,中:1,低:2}
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings
end

