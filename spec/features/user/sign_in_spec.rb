feature 'user sign in' do
  before do
    register_user
  end

  context 'succesful sign in' do
    scenario 'a user can sign in after registering' do
      sign_in
      expect(page.current_path).to eq "/space/index"
    end
  end

  context 'unsuccessful sign in' do
    scenario 'user cannot sign in with an invalid email' do
      sign_in(email: "wrong@wrong.wrong")
      expect(page).to have_content "Incorrect email or password"
    end

    scenario 'user cannot sign in with an invalid password' do
      sign_in(password: "wrongpassword")
      expect(page).to have_content "Incorrect email or password"
    end
  end
end
