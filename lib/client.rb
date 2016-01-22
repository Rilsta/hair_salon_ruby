class Client
  attr_reader(:id, :name, :stylist_id)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @stylist_id = attributes.fetch(:stylist_id)
  end

  def self.all
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each do |client|
      name = client.fetch("name")
      id = client.fetch("id").to_i
      stylist_id = client.fetch("stylist_id").to_i
      clients << Client.new({name: name, id: id, stylist_id: stylist_id})
    end
    clients
  end

  def save
    result = DB.exec("INSERT INTO clients (name, stylist_id) VALUES ('#{name}', '#{stylist_id}') RETURNING id")
    @id = result.first.fetch("id").to_i
  end

  def self.find(id)
    found_client = nil
    Client.all.each do |client|
      if client.id == id
        found_client = client
      end
    end
    found_client
  end

  def update(name)
    @name = name.fetch(:name)
    @id = self.id
    DB.exec("UPDATE clients SET (name) = ('#{@name}') WHERE id = '#{@id}';")
  end

  def delete
    DB.exec("DELETE FROM clients WHERE id = '#{self.id}';")
  end

  def ==(another_client)
    self.name == (another_client.name) &&
    (self.id == (another_client.id)) &&
    (self.stylist_id == (another_client.stylist_id))
  end
end
