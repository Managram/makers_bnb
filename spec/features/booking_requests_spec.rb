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
    # click_on "Decline"
    expect(page).to have_content('Requested on')
  end

  scenario 'declining booking request' do
    new_request = Request.create(start_date: '20/12/2016',
                                 end_date: '12/01/2017',
                                 status: 1)
    visit '/booking-requests'
    within 'li:last-child' do
      click_button 'Decline'
    end
    expect(page).not_to have_content(new_request.start_date)
    expect(page).not_to have_content(new_request.end_date)
  end
end
