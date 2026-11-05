class Task < ApplicationRecord
  belongs_to :project
  belongs_to :creator, class_name: "User"
  enum :status, { todo: 0, in_progress: 1, done: 2 }
  validates :title, presence: true
end
