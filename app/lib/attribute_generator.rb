class AttributeGenerator
  ATTRIBUTES = ['agility', 'intelligence', 'senses', 'strength']
  MAX_TOTAL = 10

  attr_accessor :desired_attrs
  attr_accessor :total

  def initialize(desired_attrs)
    @desired_attrs = desired_attrs.select { |k, _v| ATTRIBUTES.include?(k) }
    @total = 0
  end

  def generate_attrs
    loop do
      # Generate a number for each attribute
      @total = 0
      possibilities = desired_attrs.inject({}) do |gen_attrs, (name, desired_val)|
        generated_val = generate_attr(desired_val)
        gen_attrs[name] = generated_val
        @total += generated_val
        gen_attrs
      end

      # Ensure that the total attribute points is no higher than the max
      return possibilities if @total <= MAX_TOTAL

      # Otherwise decrease a random attribute and try again
      decr = ATTRIBUTES.sample
      desired_attrs[decr] = desired_attrs[decr] - 1
    end
  end

  private

  # Return a random number close-ish to the desired value
  def generate_attr(desired_value)
    min = desired_value - 2
    min = 0 if min < 0
    max = desired_value + 2
    max = 0 if max < 0
    rand(min..max)
  end
end
