require 'rails_helper'

RSpec.describe TicketPolicy do
  context 'permissions' do
    subject { TicketPolicy.new(user, ticket) }

    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    let(:ticket) { FactoryGirl.create(:ticket, project: project)}

    context 'for anonymous users' do
      let(:user) { nil }

      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
    end

    context 'for viewers of the project' do
      before { assign_role!(user, :viewer, project) }

      it { should permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
    end

    context 'for editors of the project' do
      before { assign_role!(user, :editor, project) }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should_not permit_action :update }

      context 'when editor created the ticket' do
        before { ticket.author = user }

        it { should permit_action :update }
      end
    end

    context 'for manager of the project' do
      before { assign_role!(user, :manager, project) }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
    end

    context 'for manager of other projects' do
      before do
        assign_role!(user, :manger, FactoryGirl.create(:project))

      end

      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
    end

    context 'for administrators' do
      let(:user) { FactoryGirl.create :user, :admin }

      it { should permit_action :show}
      it { should permit_action :create }
      it { should permit_action :update }
    end
  end
end
