feature 'creating a new request' do

  let(:request) { request = build(:request) }

  scenario 'user creates a request ' do
    space_request(request)
    expect(Request.first.start_date).to eq request.start_date
    expect(Request.first.end_date).to eq request.end_date
  end

end
