require "rails_helper"

RSpec.describe "Collections Show", type: :system do
  let!(:user) { create(:user) }
  let!(:collection) { create(:collection, user_id: user.id, title: "Test Collection Example") }

  before do
    create(:article) # extra article for sad path
    collection.articles << create_list(:article, 3)
  end

  context "when I visit a collections show page I see all articles listed that belong to the collection" do
    it "Signed in user" do
      sign_in user
      visit "/#{user.username}/collections/#{collection.id}"
      expect(page).to have_selector("#collections-show")
      expect(page).to have_selector("#collections-article-item", count: 3)
    end

    it "Visitor" do
      visit "/#{user.username}/collections/#{collection.id}"
      expect(page).to have_selector("#collections-show")
      expect(page).to have_selector("#collections-article-item", count: 3)
    end
  end
end
