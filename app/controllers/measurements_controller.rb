class MeasurementsController < ApplicationController
  before_filter :authenticate
  
  
  # GET /measurements
  # GET /measurements.json
  def index
    @measurements = Keyword.find(:all, :include => :latest_m).sort_by{|kw| kw.name}.map(&:latest_m)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @measurements }
    end
  end

  # GET /measurements/1
  # GET /measurements/1.json
  def show
    @measurement = Measurement.find(params[:id])
    @keyword = @measurement.keyword
    @measures = @keyword.last_30_measurements
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @measurement }
    end
  end




  private
  def authenticate
     authenticate_or_request_with_http_basic do |id, password| 
         id == MEASUREMENTS_ID && password == MEASUREMENTS_PASS
     end
  end

end