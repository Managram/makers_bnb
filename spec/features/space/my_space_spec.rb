feature 'my space' do

  scenario 'lists space details' do
    register_user
    register_space
    visit '/my-spaces'
    click_link 'new space'
    expect(page.find_field(:name).value).to eq 'new space'
    expect(page.find_field(:description).value).to eq 'anything'
    expect(find_field(:price).value).to eq '19.99'
  end

  scenario 'edit space details' do
    register_user
    register_space
    visit '/my-spaces'
    click_link 'new space'
    fill_in :name, with: 'new name'
    fill_in :description, with: 'updated desc'
    fill_in :price, with: 200
    click_button 'Edit Details'
    expect(page.find_field(:name).value).to eq 'new name'
    expect(page.find_field(:description).value).to eq 'updated desc'
    expect(page.find_field(:price).value).to eq '200.0'
    expect(page).to have_content('Details updated')
  end

end
