feature 'creating a user' do

    before :each do
      register_user
    end

    scenario 'creates a new user in the database' do
      expect(User.first.name).to eq"patrick"
    end

    before :each do
      register_space
      register_space(name: "second space")
    end

    scenario 'user can create mutliple spaces' do
      expect(Space.count).to eq 2
    end

    scenario 'users spaces are shown on space index' do
      expect(page).to have_content("new space")
      expect(page).to have_content("second space")
    end
end
