class DatasourcesController < ApplicationController
  def update_fires
    FireDispatchFetcher.new.get_fire_data
    render :nothing => true, :status => :ok
  end

  def update_police
    police_report_fetcher = PoliceReportFetcher.new  
    if Time.now.hour % 3 == 0
      police_report_fetcher.get_all_crime_data(1.day.ago.strftime('%m/%d/%Y'), Time.now.strftime('%m/%d/%Y'))
    end

    police_report_fetcher.get_all_incident_data(2, 0)
    render :nothing => true, :status => :ok
  end
end
