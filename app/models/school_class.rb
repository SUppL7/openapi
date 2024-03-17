class SchoolClass < ApplicationRecord
  validates :letter, presence: true
  validates :number, presence: true
end
