class BattleSimulator
  ATTRIBUTES = ['agility', 'intelligence', 'senses', 'strength']
  attr_reader :first
  attr_reader :second
  attr_reader :type

  def initialize(first, second, type)
    raise ArgumentError, "#{type} is not a valid attribute type" unless ATTRIBUTES.include?(type)
    @first = first
    @second = second
    @type = type
  end

  def simulate
    winner = attribute_fight(type) || attribute_fight('experience') || holistic_fight

    # "There can only be one"
    winner || [first, second].sample
  end

  private

    # Based on attribute
  def attribute_fight(attr)
    if first[attr] > second[attr]
      return first
    elsif first[attr] < second[attr]
      return second
    end
    nil
  end

  # Based on other attributes
  def holistic_fight
    first_total = attributes(first).inject(0) { |sum, (_k, v)| sum + v }
    second_total = attributes(second).inject(0) { |sum, (_k, v)| sum + v }

    if first_total > second_total
      return first
    elsif first_total < second_total
      return second
    end
  end

  def attributes(contender)
    contender.select { |k, _v| ATTRIBUTES.include?(k) }
  end
end
