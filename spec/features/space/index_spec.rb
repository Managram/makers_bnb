feature 'displays all spaces' do

  before(:each) do
    user = User.create(name: 'Rhiannon',
                     email: 'rhiannon@gmail.com',
                     username: 'rhiannon',
                     password: 'abc123',
                     password_confirmation: 'abc123')
    @space = Space.new(name: 'House',
                      description: 'Haunted',
                      price: 20.00)
    @space.user = user
    @space.save
  end

  scenario 'the page displays spaces in the database' do
    visit 'space/index'
    expect(page).to have_text @space.name
  end

  scenario 'space button links to page with space details' do
    visit 'space/index'
    click_button @space.name
    expect(page).to have_button('Request Booking')
  end
end
