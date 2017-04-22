# == Schema Information
#
# Table name: runs
#
#  id             :integer          not null, primary key
#  run_identifier :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Run < ApplicationRecord
  has_many :results
end
