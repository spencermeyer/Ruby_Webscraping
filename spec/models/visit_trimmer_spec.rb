require 'rails_helper'

RSpec.describe VisitTrimmer, type: :model do

  context 'keep the visit table to a reasonable length' do
    it 'trims the length of the visit table' do
      n = 0
      while n < 300 do
        Visit.create(ip_address: "0.0.0.#{n}", browser: "foo")
        n += 1
      end

      expect(Visit.all.count).to eq(300)
      described_class.perform
      expect(Visit.all.count).to eq(250)
    end
  end
end