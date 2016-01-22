require('spec_helper')

describe(Client) do
  describe('#id, #name') do
    it('returns information when entered into class') do
      test_client = Client.new({id: nil, name: "Dominique Diaz", stylist_id: 1})
      expect(test_client.id).to(eq(nil))
      expect(test_client.name).to(eq("Dominique Diaz"))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Client.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves input and pushes to an array') do
      test_client = Client.new({id: nil, name: "Dominique Diaz", stylist_id: 1})
      test_client.save
      expect(Client.all).to(eq([test_client]))
    end
  end

  describe('#id') do
    it('assigns an id to a client') do
      test_client = Client.new({id: nil, name: "Dominique Diaz", stylist_id: 1})
      test_client.save
      expect(test_client.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#find') do
    it('finds an entry based on its id number') do
      test_client = Client.new({id: nil, name: "Dominique Diaz", stylist_id: 1})
      test_client.save
      test_client2 = Client.new({id: nil, name: "Frank Furt", stylist_id: 2})
      test_client2.save
      expect(Client.find(test_client2.id())).to(eq(test_client2))
    end
  end

  describe('.update') do
    it('updates user information') do
      test_client = Client.new({id: nil, name: "Dominique Diaz", stylist_id: 1})
      test_client.save
      test_client.update({id: nil, name: "Fred"})
      expect(test_client.name).to(eq("Fred"))
    end
  end

  describe('.delete') do
    it('deletes a client') do
      test_client = Client.new({id: nil, name: "Dominique Diaz", stylist_id: 1})
      test_client.save
      test_client2 = Client.new({id: nil, name: "Frank Furt", stylist_id: 2})
      test_client2.save
      test_client.delete
      expect(Client.all).to(eq([test_client2]))
    end
  end

  describe('#==') do
    it('is the same client if information is the same') do
      test_client = Client.new({id: nil, name: "Dominique Diaz", stylist_id: 1})
      test_client2 = Client.new({id: nil, name: "Dominique Diaz", stylist_id: 1})
      expect(test_client).to(eq(test_client2))
    end
  end
end
