class EmergenciesController < ApplicationController
  before_filter :maintain_search_query
  
  def index
    if params[:lat] && params[:lng]
      @origin = [params[:lat], params[:lng]]
    elsif params[:address]
      @origin = params[:address]
      @origin += ', Seattle, WA' unless @origin.downcase.match('seattle')
    else
      @origin = 'Seattle, WA'
    end

    @police_reports = PoliceReport.newest.find(:all, :origin => @origin,
      :within => params[:d] || 1.5, :limit => 4,
      :order => 'reporteddate DESC')
    
    if @police_reports.length < 4
      @police_reports = @police_reports + PoliceReport.recent.find(:all, :origin => @origin,
        :within => params[:d] || 3, :limit => (4-@police_reports.length),
        :order => 'distance ASC, reporteddate DESC')
    end
    
    @fire_dispatches = FireDispatch.newest.find(:all, :origin => @origin,
      :within => params[:d] || 1.5, :limit => 4,
      :order => 'occurred DESC')
    
    if @fire_dispatches.length < 4
      @fire_dispatches = @fire_dispatches + FireDispatch.recent.find(:all, :origin => @origin,
        :within => params[:d] || 3, :limit => (4-@fire_dispatches.length),
        :order => 'distance ASC, occurred DESC')
    end
    
      
    respond_to do |format|
      format.html
      format.rss  { render :layout => false }
      format.json { render :json     => (@police_reports+@fire_dispatches).to_json }
      format.xml  { render :xml      => (@police_reports+@fire_dispatches).to_xml }
    end
  end
  
  def locator
  end
  
  protected
  def maintain_search_query
    @search_query = params[:address] || '3rd & Pike'
  end
end
