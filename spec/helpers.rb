module Helpers
  def register_space(space)
    visit '/space/new'
    fill_in :name,        with: space.name
    fill_in :description, with: space.description
    fill_in :price,       with: space.price
    click_button("create space")
  end
end
