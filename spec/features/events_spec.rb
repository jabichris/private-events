require 'rails_helper'

RSpec.feature 'Events', type: :feature, js: true do
  context 'create a new event' do
    before(:each) do
      u = User.create(username: 'User 1 test')
      visit root_path
      click_link 'Sign in'
      within('form') do
        fill_in 'user_username', with: 'User 1 test'
      end
      click_button 'Sign in'
    end
    scenario ' should be successful' do
      visit root_path
      click_link 'Create a new event'
      within('form') do
        fill_in 'event_title', with: 'Event test'
        fill_in 'event_description', with: 'Description'
        fill_in 'event_location', with: 'Location'
        fill_in 'event_date', with: Time.now + 10_000
      end
      click_button 'Create'
      expect(page).to have_content('Event test')
    end

    scenario ' should fail if no title is provided' do
      visit root_path
      click_link 'Create a new event'
      within('form') do
        fill_in 'event_title', with: ''
        fill_in 'event_description', with: 'Description'
        fill_in 'event_location', with: 'Location'
        fill_in 'event_date', with: Time.now + 10_000
      end
      click_button 'Create'
      expect(page).to have_content('Title can\'t be blank')
    end

    scenario ' should fail if no date is provided' do
      visit root_path
      click_link 'Create a new event'
      within('form') do
        fill_in 'event_title', with: 'Event test'
        fill_in 'event_description', with: 'Description'
        fill_in 'event_location', with: 'Location'
      end
      click_button 'Create'
      expect(page).to have_content('Date can\'t be blank')
    end
  end

  context 'can see event details' do
    before(:each) do
      u = User.create(username: 'User 1 test')
      e = Event.create(creator_id: u.id, title: 'Event test', date: Time.now + 100_000)
    end
    scenario 'should be successful' do
      visit root_path
      click_link 'Event test'
      sleep(2)
      expect(page).to have_content('Event test')
    end
  end
end
