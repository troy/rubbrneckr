class IncidentsController < ApplicationController
  def index
    if params[:lat] && params[:lng]
      @origin = [params[:lat], params[:lng]]
    elsif params[:address]
      @origin = params[:address]
      @origin += ', Seattle, WA' unless @origin.downcase.match('seattle')
    else
      @origin = 'Seattle, WA'
    end

    @incidents = PoliceReport.recent.find(:all, :origin => @origin,
      :within => params[:d] || 2, :limit => 4,
      :order => 'distance ASC, reporteddate DESC')
      
    respond_to do |format|
      format.html
      format.json { render :json => @incidents.to_json }
    end
  end
  
  def locator
  end
end
