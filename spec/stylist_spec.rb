require('spec_helper')

describe(Stylist) do
  describe('#id, #name') do
    it('returns information when entered into class') do
      test_stylist = Stylist.new({id: nil, name: "Estaban Diego Gonzalez Delgato Martinez"})
      expect(test_stylist.id).to(eq(nil))
      expect(test_stylist.name).to(eq("Estaban Diego Gonzalez Delgato Martinez"))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Stylist.all).to(eq([]))
    end
  end
end
