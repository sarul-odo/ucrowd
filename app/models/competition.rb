class Competition < ApplicationRecord
  belongs_to :user
  has_many :submissions
  validates :content, presence: true
  validates :explanation, presence: true
  validates :input, presence: true
  validates :output, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def self.search(search)
    where("title LIKE ? or explanation LIKE ?", "%#{search}%", "%#{search}%")
  end

end
