class SchoolClass < ApplicationRecord

  belongs_to :school
  has_many :student

  validates :letter, presence: true
  validates :number, presence: true
end
