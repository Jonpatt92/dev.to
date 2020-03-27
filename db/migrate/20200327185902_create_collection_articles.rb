class CreateCollectionArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :collection_articles do |t|
      t.references :collection, foreign_key: true
      t.references :article, foreign_key: true
    end
  end
end
