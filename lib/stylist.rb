class Stylist
  attr_reader(:id, :name)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end
end
