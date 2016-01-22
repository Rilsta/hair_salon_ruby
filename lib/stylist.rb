class Stylist
  attr_reader(:id, :name)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  def self.all
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each do |stylist|
      name = stylist.fetch("name")
      id = stylist.fetch("id").to_i
      stylists << Stylist.new({name: name, id: id})
    end
    stylists
  end

  def save
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{name}') RETURNING id")
    @id = result.first.fetch("id").to_i
  end

  def ==(another_stylist)
    self.id == another_stylist.id &&
    self.name == another_stylist.name
  end
end
