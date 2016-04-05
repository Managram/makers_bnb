feature 'space page displays information' do
  scenario 'space page displays description and price'do
    register_user
    register_space
    click_button "view space"
    expect(page).to have_text "19.99"
  end
end
