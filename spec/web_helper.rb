def register_space(name: "new space",
                   description: "anything",
                   price: 19.99)
    visit '/space/new'
    fill_in :name, with: name
    fill_in :description, with: description
    fill_in :price, with: price
    click_button("create space")
end

def register_user(name: "patrick")
  visit 'user/new'
  fill_in :name, with: name
  click_button("sign up")
end