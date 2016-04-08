feature 'user sign up' do
  context 'valid user sign up' do
    scenario 'creates a new user in the database' do
      register_user
      expect(User.first.name).to eq "patrick"
    end
  end

  context 'invalid sign up: password mismatch' do
    scenario 'user count does not increase by one when a user registers incorrectly' do
      expect{register_user(password_confirmation: "wrongpw")}.to_not change{User.count}
    end

    scenario 'display error message when passwords mismatch' do
      register_user(password_confirmation: "wrongpw")
      expect(page.current_path).to eq '/user/new'
      expect(page).to have_content 'Password does not match the confirmation'
    end
  end

  context 'invalid sign up: username' do
    scenario 'user cannot sign up with an already registered username' do
      register_user
      expect { register_user(email: "darth@vader.com") }.not_to change { User.count }
      expect(page).to have_content 'Username is already taken'
    end
  end

  context 'invalid sign up: email' do
    scenario 'user cannot sign up without entering an email' do
      register_user
      expect { register_user(email: nil) }.not_to change { User.count }
      expect(page).to have_content 'Email must not be blank'
    end

    scenario 'user cannot sign up with invalid email format' do
      expect { register_user(email: 'invalid') }.not_to change { User.count }
      expect(page).to have_content 'Email has an invalid format'
    end

    scenario 'user cannot sign up with an already registered email' do
      register_user
      expect { register_user(username: 'patty') }.not_to change { User.count }
      expect(page).to have_content 'Email is already taken'
    end
  end
end
