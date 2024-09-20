class Student < ApplicationRecord
  validates :subject_name, presence: true
  validates :marks, presence: true 
  validates :name, presence: true
end
