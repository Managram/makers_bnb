feature 'creating a new space' do
  scenario 'user creates a new space' do
    visit '/space/new'
    fill_in :name, with: "newspace"
    click_button("create space")
    expect(Space.first.name).to eq "newspace"
  end
end
