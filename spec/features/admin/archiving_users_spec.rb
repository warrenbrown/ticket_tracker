require 'rails_helper'

RSpec.feature 'An Admin can archive users' do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(admin)
  end

  scenario 'successfully' do
    visit admin_user_path(user)

    click_link 'Archive User'

    expect(page).to have_content 'User has been archived.'
    expect(page).not_to have_content user.email
  end

  scenario 'but can not archive themselves' do
    visit admin_user_path(admin)

    click_link 'Archive User'
    expect(page).to have_content 'You can not archive yourself'
  end
end
