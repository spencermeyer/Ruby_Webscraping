class Result < ApplicationRecord
  belongs_to :run
  scope :eastleigh, -> { where(club: 'Eastleigh RC') }
  scope :top12s, -> { where("age_grade_position < ?", 13 )}
    # here we will get only eastleigh resutls   :)
end
