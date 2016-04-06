feature 'user sign up' do
  context 'invalid sign up: password mismatch' do
    scenario 'user count does not increase by one when a user registers incorrectly' do
      expect{register_user(password_confirmation: "wrongpw")}.to_not change{User.count}
    end

    scenario 'display error message when passwords mismatch' do
      register_user(password_confirmation: "wrongpw")
      expect(page.current_path).to eq "/user/new"
      expect(page).to have_content "Password does not match the confirmation"
    end

  end

  context 'valid user sign up' do

    before :each do
      register_user
    end

    scenario 'creates a new user in the database' do
      expect(User.first.name).to eq "patrick"
    end

  end

end
