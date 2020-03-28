require "rails_helper"

RSpec.describe "Collections Creation", type: :system do
  let!(:user) { create(:user) }

  before do
    article1 = create(:article)
    article2 = create(:article)

    Reaction.create(reactable_id: article1.id, category: "readinglist", user_id: user.id, reactable_type: "Article", status: "valid")
    Reaction.create(reactable_id: article2.id, category: "readinglist", user_id: user.id, reactable_type: "Article", status: "valid")
    sign_in user
  end

  it "Successful Collection Creation" do
    visit "/readinglist"

    click_on "[+] Add Collection"

    expect(page).to have_current_path("/#{user.username}/collections/new", ignore_query: true)

    fill_in "Title", with: "This is a test collection"
    click_on "Save"

    expect(page).to have_current_path("/#{user.username}/collections/#{Collection.last.id}", ignore_query: true)
    expect(page).to have_selector("#collections-article-item", count: 2)
  end
end
