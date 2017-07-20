require_relative '../spec_helper'

RSpec.describe RecruitmentWorker do
  let(:generator) { AttributeGenerator.new(params) }
  let(:params) do
    {
      'agility' => 10,
      'intelligence' => 10,
      'pet_id' => 1,
      'senses' => 10,
      'strength' => 10,
      'user_id' => 1
    }
  end
  let(:worker) { described_class.new }

  describe '#perform' do
    subject { worker.perform(params) }
    before do
      allow(AttributeGenerator).to receive(:new).and_return(generator)
      allow(generator).to receive(:generate_attrs).and_return(params)
      allow(worker).to receive(:dispatch_async)
    end

    it 'should generate some attributes' do
      expect(generator).to receive(:generate_attrs)
      subject
    end

    it 'should dispatch the result' do
      expect(worker).to receive(:dispatch_async)
      subject
    end
  end
end
