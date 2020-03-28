class CollectionsController < ApplicationController
  around_action :skip_bullet, if: -> { defined?(Bullet) }

  def show
    @collection = User.find_by(username: params[:username]).collections.find_by(id: params[:id])
  end

  def new; end

  def create
    new_collection = current_user.collections.new(collection_params)
    if new_collection.save
      assign_articles(new_collection.id)
      redirect_to "/#{current_user.username}/collections/#{new_collection.id}"
    else
      flash.now[:global_notice] = "Title can't be blank"
      render :new
    end
  end

  private

  def reading_list_articles
    current_user.reactions.where(category: "readinglist").pluck(:reactable_id)
  end

  def assign_articles(collection_id)
    reading_list_articles.each do |article_id|
      CollectionArticle.create(collection_id: collection_id, article_id: article_id) if article_id
    end
    destroy_reading_list
  end

  def destroy_reading_list
    current_user.reactions.where(category: "readinglist").destroy_all
  end

  def collection_params
    params.permit(:title, :description)
  end

  def skip_bullet
    previous_value = Bullet.enable?
    Bullet.enable = false
    yield
  ensure
    Bullet.enable = previous_value
  end
end
