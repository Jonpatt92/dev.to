class AddIndexesToUsers < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :users, :net_comment_score, algorithm: :concurrently
    add_index :users, :net_article_score, algorithm: :concurrently
    add_index :users, :trailing_7_day_reactions_count, algorithm: :concurrently
    add_index :users, :trailing_28_day_reactions_count, algorithm: :concurrently
    add_index :users, :trailing_7_day_comments_count, algorithm: :concurrently
    add_index :users, :trailing_28_day_comments_count, algorithm: :concurrently
    add_index :users, :github_created_at, algorithm: :concurrently
    add_index :users, :twitter_created_at, algorithm: :concurrently
    add_index :users, :name, algorithm: :concurrently
  end
end