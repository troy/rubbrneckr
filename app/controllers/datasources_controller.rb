class DatasourcesController < ApplicationController
  def update_fires
    FireDispatchFetcher.new.get_fire_data
    render :nothing => true, :status => :ok
  end
end
