require 'rails_helper'

RSpec.describe "Goals", type: :request do

  goal = FactoryGirl.create(:goal)
  
  context "GET /goals" do

  	
    it "display some goals" do
  		visit goals_path
  		expect(page).to have_content 'Rubyist'  	
    end
  end

  context "create new task" do
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

  context "edit created task", :js=>true do

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
      fill_in 'Name', with: 'Edited_name'
      fill_in 'Description', with: 'Edited goal'
      fill_in 'Term', with: '20-11-2020'
      click_on 'Update Goal'
      assert_equal current_path, goal_path(goal)
      visit goals_path
      expect(page).to have_content 'Edited_name'
    end
  end

  context "delete task" do

      it "delete goal", :js=>true do
        visit goals_path
        visit goal_path(goal)
        click_on 'Delete'
        page.driver.browser.switch_to.alert.accept   
        visit goals_path
        expect(page).to have_no_content 'Edited_name'
      end
    end
end
