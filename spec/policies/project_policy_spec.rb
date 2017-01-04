require 'rails_helper'

RSpec.describe ProjectPolicy do

  subject { described_class }

  context "permissoin" do
    subject { ProjectPolicy.new(user, project) }

    let!(:project) { FactoryGirl.create :project }
    let(:user) { FactoryGirl.create :user }

    context "for anonymous users" do
      let(:user) { nil }

      it { should_not permit_action :show }
      it { should_not permit_action :update}
    end

    context 'for viewers of the project' do
      before { assign_role!(user, :viewer, project) }

      it { should permit_action :show }
      it { should_not permit_action :update }
    end

    context 'for editors of the project' do
      before { assign_role!(user, :editor, project) }

      it { should permit_action :show }
      it { should_not permit_action :update }
    end

    context 'for managers of he project' do
      before { assign_role!(user, :manager, project) }

      it { should permit_action :show }
      it { should permit_action :update}
    end

    context 'for managers of other projects' do
      before do
        assign_role!(user, :manager, FactoryGirl.create(:project))
      end
      it { should_not permit_action :show }
      it {should_not permit_action :update }
    end

    context 'for administrators' do
      let(:user) { FactoryGirl.create :user, :admin }

      it { should permit_action :show }
      it { should permit_action :update }
    end
  end
end
