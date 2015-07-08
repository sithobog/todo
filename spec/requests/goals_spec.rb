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
      click_on 'Show'
      click_on 'Edit Goal'
      assert_equal current_path, edit_goal_path(goal)
    end
  end
end
