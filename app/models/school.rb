class School < ApplicationRecord
  has_many :school_class
  has_many :student
end
