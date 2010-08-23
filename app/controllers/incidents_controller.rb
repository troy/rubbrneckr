class IncidentsController < ApplicationController
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

    @incidents = PoliceReport.newest.find(:all, :origin => @origin,
      :within => params[:d] || 2, :limit => 4,
      :order => 'distance ASC, reporteddate DESC')
    
    if @incidents.length < 4
      @incidents = @incidents + PoliceReport.recent.find(:all, :origin => @origin,
        :within => params[:d] || 2, :limit => (4-@incidents.length),
        :order => 'distance ASC, reporteddate DESC')
    end
      
    respond_to do |format|
      format.html
      format.rss  { render :layout => false }
      format.json { render :json     => @incidents.to_json }
      format.xml  { render :xml      => @incidents.to_xml }
    end
  end
  
  def locator
  end
  
  protected
  def maintain_search_query
    @search_query = params[:address] || '3rd & Pike'
  end
end
