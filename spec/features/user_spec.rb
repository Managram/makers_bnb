feature 'creating a user' do

    scenario 'user count does not change when user is not authenticated' do
      expect(register_user).to change{User.count}.by(1)
    end

    before :each do
      register_user
    end

    let!(:user) do
      User.create(name: 'test', email: 'test@test.com', username: 'test', password: 'secret1234', password_confirmation: 'secret1234')
    end

    scenario 'authenticates a user when given a valid email address and password' do
      authenticated_user = User.authenticate(user.username, user.password)
      expect(authenticated_user).to eq user
    end

    scenario 'does not authenticate a user when given an invalid email address and password' do
      authenticated_user = User.authenticate(user.username, "invalidpassword")
      expect(authenticated_user).not_to eq user
    end



    scenario 'creates a new user in the database' do
      expect(User.first.name).to eq"patrick"
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
