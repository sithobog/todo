require 'rails_helper'

RSpec.describe "Goals", type: :request do
  goal = FactoryGirl.create(:goal)
  
  describe "GET /goals" do

  	
    it "display some goals" do

  		visit goals_path
  		expect(page).to have_content 'Rubyist'
  	
    end
  end

  describe "create new task" do
  	it "create a new task" do
  		visit goals_path
  		click_link 'New goal'
  		fill_in 'Name', with: goal.name
  		fill_in 'Description', with: goal.description
      fill_in 'Term', with: goal.term
  		click_on 'Create Goal'
      have_content goal.name
      have_content goal.description
      have_content goal.term
    end
  end

  describe "edit created task" do

    it "go to edit_path" do
      visit goals_path
      within("#goal_#{goal.id}") do
        click_on 'Show'
      end
      click_on 'Edit Goal'
      assert_equal current_path, edit_goal_path(goal)
    end

    it "update goal" do
      visit edit_goal_path(goal)
      fill_in 'Name', with: 'Hola Wola'
      fill_in 'Description', with: 'Edited goal'
      fill_in 'Term', with: '20-11-2020'
      click_on 'Update Goal'
      assert_equal current_path, goal_path(goal)
      expect(page).to have_content 'Edited goal'
    end

  end
end
