feature 'booking requests' do

  scenario 'lists booking requests' do
    create_request
    visit '/my-bookings'
    within 'ul' do
      expect(page).to have_content('2016-12-20')
      expect(page).to have_content('2016-04-08')
    end
  end


  scenario 'accepting booking request' do
    create_request
    visit '/my-spaces'
    click_link 'new space'
    click_on "Accept"
    expect(page).not_to have_button('Accept')
  end

  scenario 'declining booking request' do
    create_request
    visit '/my-spaces'
    click_link 'new space'
    within 'li:last-child' do
      click_button 'Decline'
    end
    expect(page).not_to have_button('Decline')
  end
 end
