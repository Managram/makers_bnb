feature 'user sign in' do

  let!(:user) do
    User.create(name: 'test', email: 'test@test.com', username: 'test', password: 'secret1234', password_confirmation: 'secret1234')
  end

  context 'unsuccessful sign in' do
    scenario 'does not authenticate a user when given an invalid email address and password' do
      authenticated_user = User.authenticate(user.username, "invalidpassword")
      expect(authenticated_user).not_to eq user
    end
  end

  context 'successful sign in' do
    scenario 'authenticates a user when given a valid email address and password' do
      authenticated_user = User.authenticate(user.username, user.password)
      expect(authenticated_user).to eq user
    end
  end
end
