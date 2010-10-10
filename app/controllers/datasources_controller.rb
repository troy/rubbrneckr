class DatasourcesController < ApplicationController
  def update_fires
    FireDispatchFetcher.new.get_fire_data
    render :status => :ok
  end
end
