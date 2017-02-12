class Result < ApplicationRecord
  belongs_to :run
  scope :eastleigh, -> { where(club: 'Eastleigh RC') }
    # here we will get only eastleigh resutls   :)
end
