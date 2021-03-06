require 'rails_helper'

RSpec.feature 'Admins can create users' do
  let(:admin) { FactoryGirl.create(:user, :admin) }

 before do
   login_as(admin)
   visit '/'
   click_link 'Admin'
   click_link 'Users'
   click_link 'New User'
 end

 scenario 'with valid attributes' do
   fill_in 'Email', with: 'newbie@example.com'
   fill_in 'Password', with: 'password'
   click_button 'Create User'

   expect(page).to have_content 'User has been created.'
 end

 scenario 'when the user is an admin user' do
   fill_in 'Email', with: 'johndoe@example.com'
   fill_in 'Password', with: 'password'
   check 'Is an admin?'
   click_button 'Create User'

   expect(page).to have_content 'User has been created.'
   expect(page).to have_content 'johndoe@example.com (Admin)'
 end
end
