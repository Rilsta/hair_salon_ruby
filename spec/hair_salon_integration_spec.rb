require('capybara/rspec')
require('./app.rb')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('hair salon pathways', {:type => :feature}) do
  describe('Adding a stylist route') do
    it('adds stylist to stylist list page') do
      visit('/')
      click_link('Add New Stylist')
      fill_in('name', with: 'Pierre Baguette')
      click_button('Submit')
      click_link('View Stylists')
      expect(page).to have_content('Pierre Baguette')
    end
  end

  describe('Adding a client route') do
    it('adds a client to a stylist') do
      test_client = Client.new({id: nil, name: "Frank Furt", stylist_id: 1}).save
      test_stylist = Stylist.new({id: nil, name: "Beatrice Hairperson"})
      test_stylist.save
      visit "/stylists"
      click_link "Beatrice Hairperson"
      fill_in "name", :with => "Frank Furt"
      click_button "Submit"
      expect(page).to have_content("SUUUPER!")
    end
  end
end
