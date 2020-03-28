require "rails_helper"

RSpec.describe CollectionArticle, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to :collection }
    it { is_expected.to belong_to :article }
  end
end
