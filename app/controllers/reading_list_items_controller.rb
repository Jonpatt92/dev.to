class ReadingListItemsController < ApplicationController
  def index
    # used in _styles.html.erb
    @reading_list_items_index = true
    # more than one route ends in this index action, set_view checks to see if the request is for reading list or [archived]reading list
    set_view
    # grabs algolia search key from hidden file to pass through erb to javascript file
    generate_algolia_search_key
  end

  def update
    @reaction = Reaction.find(params[:id])
    not_authorized if @reaction.user_id != session_current_user_id

    @reaction.status = params[:current_status] == "archived" ? "valid" : "archived"
    @reaction.save
    head :ok
  end

  private

  def generate_algolia_search_key
    params = { filters: "viewable_by:#{session_current_user_id}" }
    @secured_algolia_key = Algolia.generate_secured_api_key(
      ApplicationConfig["ALGOLIASEARCH_SEARCH_ONLY_KEY"], params
    )
  end

  # checks params before setting @view that is then passed through erb to javascript file to determine what content to render to view
  def set_view
    @view = if params[:view] == "archive"
              "archived"
            else
              "valid"
            end
  end
end
