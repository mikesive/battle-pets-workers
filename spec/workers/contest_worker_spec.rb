require_relative '../spec_helper'

RSpec.describe ContestWorker do
  let(:attributes) do
    {
      'agility' => 10,
      'intelligence' => 10,
      'pet_id' => 1,
      'senses' => 10,
      'strength' => 10,
      'user_id' => 1
    }
  end
  let(:first_contestant) { attributes.merge('id' => 1) }
  let(:second_contestant) { attributes.merge('id' => 2) }
  let(:simulator) { BattleSimulator.new(first_contestant, second_contestant, 'strength') }
  let(:params) do
    {
      'first_contestant' => first_contestant,
      'second_contestant' => second_contestant,
      'battle_id' => 1,
      'battle_type' => 'agility'
    }
  end

  let(:worker) { described_class.new }

  describe '#perform' do
    subject { worker.perform(params) }
    before do
      allow(BattleSimulator).to receive(:new).and_return(simulator)
      allow(simulator).to receive(:simulate).and_return(first_contestant)
      allow(worker).to receive(:dispatch_async)
    end

    it 'should simulate a battle' do
      expect(simulator).to receive(:simulate)
      subject
    end

    it 'should dispatch the result' do
      expect(worker).to receive(:dispatch_async)
      subject
    end
  end
end
