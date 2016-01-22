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

  def self.find(id)
    found_stylist = nil
    Stylist.all.each do |stylist|
      if stylist.id == id
        found_stylist = stylist
      end
    end
    found_stylist
  end

  def update(name)
    @name = name.fetch(:name)
    @id = self.id
    DB.exec("UPDATE stylists SET (name) = ('#{@name}') WHERE id = '#{@id}';")
  end

  def delete
    DB.exec("DELETE FROM stylists WHERE id = '#{self.id}';")
  end

  def ==(another_stylist)
    self.name == (another_stylist.name) &&
    (self.id == (another_stylist.id))
  end
end
