class CollectionsController < ApplicationController
  around_action :skip_bullet, if: -> { defined?(Bullet) }

  def show
    @collection = User.find_by(username: params[:username]).collections.find_by(id: params[:id])
  end

  private

  def skip_bullet
    previous_value = Bullet.enable?
    Bullet.enable = false
    yield
  ensure
    Bullet.enable = previous_value
  end
end
