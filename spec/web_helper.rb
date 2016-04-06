def register_space(name: "new space",
                   description: "anything",
                   price: 19.99)
    visit '/space/new'
    fill_in :name, with: name
    fill_in :description, with: description
    fill_in :price, with: price
    click_button("create space")
end

def register_user(name: "patrick",
                  email: "email@email.com",
                  username: "pdon",
                  password: "password",
                  password_confirmation: "password")
  visit '/user/new'
  fill_in :name, with: name
  fill_in :email, with: email
  fill_in :username, with: username
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button("Sign up")
end

def sign_in(email: "email@email.com",
            password: "password")
  visit '/sessions/new'
  fill_in :email, with: email
  fill_in :password, with: password
  click_button("Sign in")
end
