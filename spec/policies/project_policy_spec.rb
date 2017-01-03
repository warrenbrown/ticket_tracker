require 'rails_helper'

RSpec.describe ProjectPolicy do

  subject { described_class }

  permissions ".scope" do
  end

  permissions :show? do
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project)}

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, project)
    end

    it 'allows viewers of the project' do
      assign_role!(user, :viewer, project)
      expect(subject).to permit(user, project)
    end

    it 'allows editors of project' do
      assign_role!(user, :editor, project)
      expect(subject).to permit(user, project)
    end

    it 'allows managers of project' do
      assign_role!(user, :manager, project)
      expect(subject).to permit(user, project)
    end

    it 'allows administrators of project' do
      admin = FactoryGirl.create :user, :admin
      expect(subject).to permit(admin, project)
    end

    it 'does not allow users assigned to other projects' do
      other_project = FactoryGirl.create(:project)
      assign_role!(user, :manager, other_project)
      expect(subject).not_to permit(user, project)
    end
  end

  permissions :create? do
  end

  permissions :update? do
  end

  permissions :destroy? do
  end
end
