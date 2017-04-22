# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  ip_address :text
#  browser    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Visit, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
