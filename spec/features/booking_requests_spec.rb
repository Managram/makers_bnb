feature 'booking requests' do

  let(:request) { request = create(:request) }

  scenario 'lists booking requests' do
    visit '/booking-requests'
    within 'ul' do
      expect(page).to have_content(request.start_date)
      expect(page).to have_content(request.end_date)
    end
  end
end
