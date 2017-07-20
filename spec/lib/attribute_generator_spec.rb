require_relative '../spec_helper'

RSpec.describe AttributeGenerator do
  let(:desired_attributes) do
    { 'agility' => 10, 'intelligence' => 10, 'senses' => 10, 'strength' => 10 }
  end
  let(:attribute_generator) { described_class.new(desired_attributes) }

  describe '#generate_attrs' do
    subject { attribute_generator.generate_attrs }
    it 'should generate an attr at least once for each desired attr' do
      expect(attribute_generator).to receive(:generate_attr).at_least(4).times.and_call_original
      subject
    end

    it 'should total less than 10' do
      5.times do
        generator = described_class.new(desired_attributes)
        generator.generate_attrs
        expect(generator.total).to be_between(0, described_class::MAX_TOTAL).inclusive
      end
    end

    # In theory this test could fail, but is unlikely to
    it 'should not be deterministic' do
      totals = []
      10.times do
        generator = described_class.new(desired_attributes)
        generator.generate_attrs
        totals.push(generator.total)
      end
      expect(totals.uniq.size).to be > 1
    end
  end
end
