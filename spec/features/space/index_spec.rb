feature 'displays all spaces' do
  scenario 'the page displays spaces in the database' do
    register_user
    register_space
    expect(page).to have_text "new space"
  end
end
