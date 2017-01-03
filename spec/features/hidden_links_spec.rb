require 'rails_helper'

RSpec.feature 'Users can only see the appropriate links' do
  let(:project) { FactoryGirl.create(:project) }
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }


  context 'non admin user (project viewers)' do
    before do
      login_as(user)
      assign_role!(user, :viewer, project)
    end

    scenario 'can not see the New Project link' do
      visit project_path(project)

      expect(page).not_to have_link 'New Project'
    end

    scenario 'can not see the delete link' do
      visit project_path(project)
      expect(page).not_to have_link 'Delete Project'
    end
  end

  context 'Admin users' do
    before { login_as(admin) }

    scenario 'admin users can see the New Project link' do
      visit '/'

      expect(page).to have_link 'New Project'
    end

    scenario 'admin users can see the Delete Project link' do
      visit project_path(project)

      expect(page).to have_link 'Delete Project'
    end
  end
end
