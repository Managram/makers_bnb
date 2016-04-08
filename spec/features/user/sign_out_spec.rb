feature 'user sign out' do
  scenario 'a current user can sign out' do
    register_user
    click_button 'Sign out'
    expect(page).to have_content 'Sign In'
  end
end
