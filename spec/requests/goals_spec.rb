require 'rails_helper'

RSpec.describe "Goals", type: :request do
  describe "GET /goals" do
  	it "display some goals" do
  		visit goals_path
  		expect(page).to have_content 'go to bed'
  	end
  end
end
