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
end
