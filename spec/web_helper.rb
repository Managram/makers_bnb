def register_space(name: "newspace",
                   description: "anything",
                   price: 19.99)
    visit '/space/new'
    fill_in :name, with: name
    fill_in :description, with: description
    fill_in :price, with: price
    click_button("create space")
end