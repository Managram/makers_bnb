# feature 'booking requests' do
#
#   let(:request) { request = create(:request) }
#
#   scenario 'lists booking requests' do
#     visit '/booking-requests'
#     within 'ul' do
#       expect(page).to have_content(request.start_date)
#       expect(page).to have_content(request.end_date)
#     end
#   end
#
#   scenario 'accepting booking request' do
#     new_request = Request.create(start_date: '20/12/2016',
#                                  end_date: '12/01/2017',
#                                  status: 1)
#     visit '/booking-requests'
#     within "li:last-child" do
#       click_button "Accept"
#     end
#     expect(page).not_to have_content(new_request.start_date)
#     expect(page).not_to have_content(new_request.end_date)
#   end
#
#   scenario 'declining booking request' do
#     new_request = Request.create(start_date: '20/12/2016',
#                                  end_date: '12/01/2017',
#                                  status: 1)
#     visit '/booking-requests'
#     within 'li:last-child' do
#       click_button 'Decline'
#     end
#     expect(page).not_to have_content(new_request.start_date)
#     expect(page).not_to have_content(new_request.end_date)
#   end
# end
