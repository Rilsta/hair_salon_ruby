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
    @name = name.fetch("name")
    @id = self.id
    DB.exec("UPDATE stylists SET (name) = ('#{@name}') WHERE id = '#{@id}';")
  end

  def delete
    DB.exec("DELETE FROM stylists WHERE id = '#{self.id}';")
  end

  def client
    stylist_clients = []
    clients = DB.exec("SELECT * FROM clients WHERE stylist_id = '#{self.id()}';")
    clients.each do |client|
      name = client.fetch("client")
      stylist_id = client.fetch('stylist_id').to_i
      id = client.fetch('id').to_i
      stylist_clients << Client.new({name: name, id: id, stylist_id: stylist_id})
    end
    stylist_clients
  end

  def ==(another_stylist)
    self.name == (another_stylist.name) &&
    (self.id == (another_stylist.id))
  end
end
