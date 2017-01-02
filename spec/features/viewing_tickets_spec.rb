require 'rails_helper'

RSpec.feature 'Users can view tickets' do
  before do
    sublime = FactoryGirl.create(:project, name: 'Sublime Text 3')
    FactoryGirl.create(:ticket, project: sublime, name: 'Make it shit', description: 'Graidients and Starburst, oh my')

    ie = FactoryGirl.create(:project, name: 'Internet explorer')
    FactoryGirl.create(:ticket, project: ie, name: 'Standards compliance', description: 'Is not a joke.')

    visit '/'
  end

  scenario 'for a given project ' do
    click_link 'Sublime Text 3'

    expect(page).to have_content 'Make it shit'
    expect(page).to_not have_content 'Standards compliance'

    click_link 'Make it shit'

    within("#ticket h2") do
      expect(page).to have_content 'Make it shit'
    end
    expect(page).to have_content 'Graidients and Starburst, oh my'
  end
end
