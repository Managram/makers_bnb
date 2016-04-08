feature 'user creating a space' do
  before :each do
    register_user
  end

  context 'invalid space creation' do
    scenario 'cannot create space without a space name' do
      expect { register_space(name: nil) }.not_to change { Space.count }
    end

    scenario 'cannot create space without space description' do
      expect { register_space(description: nil) }.not_to change { Space.count }
    end

    scenario 'cannot create space without a price' do
      expect { register_space(price: nil) }.not_to change { Space.count }
    end

    scenario 'cannot create space with an pre-existing name' do
      register_space
      expect { register_space }.not_to change { Space.count }
    end
  end

  context 'creating multiple spaces' do
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
end
