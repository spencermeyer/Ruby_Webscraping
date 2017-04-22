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

class Visit < ApplicationRecord
end
