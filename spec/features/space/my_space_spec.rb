feature 'my space' do

  scenario 'lists space details' do
    register_user
    register_space
    visit '/my-spaces'
    click_link 'new space'
    find_field(:name).value.should eq 'new space'
    find_field(:description).value.should eq 'anything'
    find_field(:price).value.should eq '19.99'
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
    find_field(:name).value.should eq 'new name'
    find_field(:description).value.should eq 'updated desc'
    find_field(:price).value.should eq '200.0'
    expect(page).to have_content('Details updated')
  end

end
