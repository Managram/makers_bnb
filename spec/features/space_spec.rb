feature 'creating a new space' do

  let(:space) { space = build(:space) }

  scenario 'user creates a new space name' do
    register_space(space)
    expect(Space.first.name).to eq space.name
  end

  scenario 'user creates a new space with a description' do
    register_space(space)
    expect(Space.first.description).to eq space.description
  end

  scenario 'user created a new space with a price' do
    register_space(space)
    expect(Space.first.price).to eq space.price
  end

end
