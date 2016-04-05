feature 'creating a user' do

    scenario 'creates a new user in the database' do
      register_user
      expect(User.first.name).to eq"patrick"
    end

    scenario 'user can create mutliple spaces' do
      register_user
      register_space
      register_space(name: "second space")
      expect(Space.count).to eq 2
    end

    scenario 'users spaces are shown on space index' do
      register_user
      register_space
      register_space(name: "second space")
      expect(page).to have_content("new space")
      expect(page).to have_content("second space")
    end
end
