require 'rails_helper'

RSpec.feature 'Admin users can create states' do
  let(:user) { FactoryGirl.create(:user, :admin) }
  before do
    login_as(user)
    visit admin_root_path
  end

  scenario 'with valid attributes' do
    click_link 'States'
    click_link 'New State'
    fill_in 'Name', with: "Won't fix"
    fill_in 'Color', with: 'Orange'
    click_button 'Create State'

    expect(page).to have_content 'State has been created'
  end
end
