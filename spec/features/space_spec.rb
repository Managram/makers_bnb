feature 'creating a new space' do

  scenario 'user creates a new space name' do
    register_user
    register_space
    expect(Space.first.name).to eq "new space"
  end

  scenario 'user creates a new space with a description' do
    register_user
    register_space
    expect(Space.first.description).to eq "anything"
  end

  scenario 'user created a new space with a price' do
    register_user
    register_space
    expect(Space.first.price).to eq 19.99
  end

end
