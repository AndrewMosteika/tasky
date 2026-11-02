class Task < ApplicationRecord
  belongs_to :project
  enum :status, { todo: 0, in_progress: 1, done: 2 }
  validates :title, presence: true
end
