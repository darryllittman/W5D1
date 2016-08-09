require 'spec_helper'
require 'rails_helper'

feature "goal creation" do
  before(:each) do
    visit new_user_url
    fill_in 'Username', with: "user"
    fill_in 'Password', with: "password"
    click_on "Create Account"

    visit new_goal_url
    fill_in 'Title', with: "run 3 marathons"
    fill_in 'Description', with: "Text about running 3 marathons"
    choose('Public')
    click_on "Create Goal"
  end

  scenario "shows goal upon creation" do
    expect(page).to have_content("run 3 marathons")
  end

  scenario "new goal defaults to uncompleted" do
    expect(page).to have_content("status: uncompleted")
  end
end

feature "goal viewing" do
  before(:each) do
    visit new_user_url
    fill_in 'Username', with: "user"
    fill_in 'Password', with: "password"
    click_on "Create Account"
  end

  scenario "public goals are globally viewable" do
    goal = create(:goal, user_id: User.all.first.id)
    visit goals_url
    expect(page).to have_content("a_public_goal")
  end

  scenario "user can see own private goals" do
    goal = create(:goal, private: "private", user_id: User.all.first.id)
    visit goals_url
    expect(page).to have_content("a_public_goal")
  end

  scenario "completed goals are marked 'completed'" do
    goal = create(:goal, status: "completed", user_id: User.all.first.id)
    visit goals_url
    expect(page).to have_content("status: completed")
  end
end

feature "goal deletion" do
  before(:each) do
    visit new_user_url
    fill_in 'Username', with: "user"
    fill_in 'Password', with: "password"
    click_on "Create Account"
  end

  scenario "uncompleted goals must remain on page" do
    goal = create(:goal, status: "uncompleted", user_id: User.all.first.id)
    visit goal_url(goal)
    expect(page).to_not have_content("Delete Goal")
  end

  scenario "you may delete a completed goal" do
    goal = create(:goal, status: "completed", user_id: User.all.first.id)
    visit goal_url(goal)
    expect(page).to have_button("Delete Goal")
  end

  scenario "users are awarded points for completed goals" do
    goal = create(:goal, status: "completed", user_id: User.last.id)
    user = User.last
    points = user.points
    visit goal_url(goal)
    click_on "Delete Goal"

    expect(User.last.points).to eq(points + 62)
  end
end
