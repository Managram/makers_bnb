feature 'user creating a space' do

  before :each do
    register_user
  end

  let!(:user) do
    User.create(name: 'test', email: 'test@test.com', username: 'test', password: 'secret1234', password_confirmation: 'secret1234')
  end

  before :each do
    register_space
    register_space(name: "second space")
  end

  scenario 'user can create mutliple spaces' do
    expect(Space.count).to eq 2
  end

  scenario 'users spaces are shown on space index' do
    expect(page).to have_content("new space")
    expect(page).to have_content("second space")
  end
end
