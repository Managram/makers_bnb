feature 'booking requests' do

  # let(:request) { request = create(:request) }

  # scenario 'lists booking requests' do
  #   visit '/booking-requests'
  #   within 'ul' do
  #     expect(page).to have_content(request.start_date)
  #     expect(page).to have_content(request.end_date)
  #   end
  # end

  scenario 'accepting booking request' do
    request = Request.new(start_date: '20/12/2016',
                             end_date: '12/01/2017',
                             status: 1)
    p request.save
    visit '/booking-requests'
    p num = request.id
    within "li#num" do
      p request.status
      click_button "Accept"
      p request.status
      expect(page).not_to have_content(request.start_date)
      expect(page).not_to have_content(request.end_date)
    end
  end

  scenario 'declining booking request' do
    visit '/booking-requests'
    within 'ul' do
      click_button 'Decline'
      expect(page).not_to have_content(request.start_date)
      expect(page).not_to have_content(request.end_date)
    end
  end
end
