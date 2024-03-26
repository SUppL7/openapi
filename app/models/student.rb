class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  belongs_to :school_class
  belongs_to :school

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :surname, presence: true
end

