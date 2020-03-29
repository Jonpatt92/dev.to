require "rails_helper"

RSpec.describe "Collections Index", type: :system do
  let!(:user) { create(:user) }

  before do
    create(:collection, user_id: user.id, title: "Example 1")
    create(:collection, user_id: user.id, title: "Example 2")
    sign_in user
  end

  context "when readinglist renders" do
    it "collections-index" do
      visit "/readinglist"
      expect(page).to have_selector("#collections-index")
    end

    it "collections-items" do
      visit "/readinglist"
      within "#collections-index" do
        expect(page).to have_selector("#collections-item", count: 2)
      end
    end

    it "collections-add-btn" do
      visit "/readinglist"
      expect(page).to have_button("[+] Add Collection")
    end
  end
end
