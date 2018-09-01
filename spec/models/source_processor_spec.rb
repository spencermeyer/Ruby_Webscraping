require 'rails_helper'
include ScrapesHelper
require "#{Rails.root}/lib/scrapes/browserchoice"

RSpec.describe SourceProcessor, type: :model do
  let(:mechanize_dub)  { double('Mechanize') }
  let(:resque)         { double(Resque) }
  let(:element)        { double() }
  let(:link)           { double() }
  let(:fake_doc)       { double() }

  context 'source processor normally queues jobs', normal: true do
    it 'gets the source index' do
      expect(Mechanize).to receive(:new) { mechanize_dub }
      expect(mechanize_dub).to receive(:user_agent_alias=)
      expect(mechanize_dub).to receive(:get).and_return(fake_doc)
      expect(fake_doc).to receive(:xpath).and_return([element, element, element])
      allow(element).to receive_message_chain(:attributes, :[], :value).and_return(link)
      expect(link).to receive(:sub!).and_return(true).exactly(3).times
      expect(Resque).to receive(:enqueue_at).exactly(6).times.and_return(true)
      expect(described_class).to be SourceProcessor
      described_class.perform
    end
  end

  context 'when there were no links', empty: true do
    it 'doesnt fail' do
      expect(Mechanize).to receive(:new) { mechanize_dub }
      expect(mechanize_dub).to receive(:user_agent_alias=).and_return('foo')
      expect(mechanize_dub).to receive(:get).and_return(fake_doc)
      expect(fake_doc).to receive(:xpath).and_return(nil)
      expect(Resque).not_to receive(:enqueue_at)
      described_class.perform
    end
  end
end
