require_relative '../spec_helper'

RSpec.describe BattleSimulator do
  let(:base) do
    { 'agility' => 0, 'intelligence' => 0, 'senses' => 0, 'strength' => 0, 'experience' => 0
    }
  end

  let(:first_contestant) { base.merge(user_id: 1) }
  let(:second_contestant) { base.merge(user_id: 2) }

  let(:simulator) { described_class.new(first_contestant, second_contestant, type) }

  subject { simulator.simulate }

  describe 'agility fight' do
    let(:type) { 'agility' }
    before do
      first_contestant['agility'] = 1
      second_contestant['strength'] = 10
    end
    it { is_expected.to eq(first_contestant) }
  end

  describe 'experience fight' do
    let(:type) { 'agility' }
    before { second_contestant['experience'] = 1 }
    it { is_expected.to eq(second_contestant) }
  end

  describe 'intelligence fight' do
    let(:type) { 'intelligence' }
    before { first_contestant['intelligence'] = 1 }
    it { is_expected.to eq(first_contestant) }
  end

  describe 'senses fight' do
    let(:type) { 'senses' }
    before { second_contestant['senses'] = 1 }
    it { is_expected.to eq(second_contestant) }
  end

  describe 'strength fight' do
    let(:type) { 'strength' }
    before { second_contestant['strength'] = 1 }
    it { is_expected.to eq(second_contestant) }
  end

  describe 'holistic fight' do
    let(:type) { 'strength' }
    before do
      first_contestant['senses'] = 10
      second_contestant['senses'] = 1
    end
    it { is_expected.to eq(first_contestant) }
  end
end
