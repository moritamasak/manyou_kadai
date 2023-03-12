class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  scope :name_search,  -> (params) {where('name LIKE ?',"%#{params[:task][:name]}%")}
  scope :status_search, -> (params) {where(status: params[:task][status])}
  enum status:{未着手:0,着手中:1,完了:2}
  enum priority:{高:0,中:1,低:2}
end

