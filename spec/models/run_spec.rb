# == Schema Information
#
# Table name: runs
#
#  id             :integer          not null, primary key
#  run_identifier :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Run, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
