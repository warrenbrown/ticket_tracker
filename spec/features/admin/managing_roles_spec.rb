require 'rails_helper'

RSpec.feature 'Admin users can manage a users role' do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }

  let(:ie) { FactoryGirl.create(:projcet, name: 'Internet Explorer')}
  let(:s3) { FactoryGirl.create(:project, name: 'Sublime Text 3')}

  before do
    login_as(admin)
  end

  scenario "when assigning roles to an existing user" do
    visit admin_user_path(user)

    click_link "Edit User"
      select "Viewer", from: "Internet Explorer"
      select "Manager", from: "Sublime Text 3"

    click_button "Update User"

    expect(page).to have_content "User has been updated"

    click_link user.email
    expect(page).to have_content "Internet Explorer: Viewer"
    expect(page).to have_content "Sublime Text 3: Manager"
  end

  scenario 'when assigning roles to new users' do
    visit new_admin_user_path(user)

    fill_in 'Email', with: 'newuser@tickettracker.com'
    fill_in 'Password', with: 'password'

    select 'Editor', from: 'Sublime Text 3'
    click_button 'Create User'

    click_link 'newuser@tickettracker.com'
    expect(page).to have_content "Internet Explorer: Editor"
    expect(page).not_to have_content "Sublime Text 3"
  end
end
