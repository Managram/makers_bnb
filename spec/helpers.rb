module Helpers
  def register_space(space)
    visit '/space/new'
    fill_in :name,        with: space.name
    fill_in :description, with: space.description
    fill_in :price,       with: space.price
    click_button("create space")
  end

  # def space_request(request)
  #   visit '/request/new'
  #   fill_in :start_date, with: request.start_date
  #   fill_in :end_date,   with: request.end_date
  #   click_button("send request")
  # end
end
