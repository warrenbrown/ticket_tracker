require 'rails_helper'

RSpec.feature 'Users can only see the appropriate links' do
  let(:project) { FactoryGirl.create(:project) }
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }

  context 'anonymous users' do
    scenario 'can not see the New project link' do
      visit '/'

      expect(page).not_to have_link 'New Project'
    end

    scenario 'can not see the delete link' do
      visit project_path(project)
      expect(page).not_to have_link 'Delete Project'
    end
  end

  context 'regular user' do
    before { login_as(user) }

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
