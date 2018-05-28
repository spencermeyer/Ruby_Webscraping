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
  serialize :metadata, Hash
  has_many :results

  def comment
    metadata['comment']
  end

  def comment=(arg)
    metadata['comment'] = arg
  end
end
