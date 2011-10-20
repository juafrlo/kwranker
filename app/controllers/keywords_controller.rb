class KeywordsController < ApplicationController
  before_filter :authenticate

  # GET /keywords
  # GET /keywords.json
  def index
    @keywords = Keyword.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @keywords }
    end
  end

  # GET /keywords/1
  # GET /keywords/1.json
  def show
    @keyword = Keyword.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @keyword }
    end
  end

  # GET /keywords/new
  # GET /keywords/new.json
  def new
    @keyword = Keyword.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @keyword }
    end
  end

  # GET /keywords/1/edit
  def edit
    @keyword = Keyword.find(params[:id])
  end

  # POST /keywords
  # POST /keywords.json
  def create
    @keyword = Keyword.new(params[:keyword])

    respond_to do |format|
      if @keyword.save
        format.html { redirect_to @keyword, :notice => 'Keyword was successfully created.' }
        format.json { render :json => @keyword, :status => :created, :location => @keyword }
      else
        format.html { render :action => "new" }
        format.json { render :json => @keyword.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /keywords/1
  # PUT /keywords/1.json
  def update
    @keyword = Keyword.find(params[:id])

    respond_to do |format|
      if @keyword.update_attributes(params[:keyword])
        format.html { redirect_to @keyword, :notice => 'Keyword was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @keyword.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1
  # DELETE /keywords/1.json
  def destroy
    @keyword = Keyword.find(params[:id])
    @keyword.destroy

    respond_to do |format|
      format.html { redirect_to keywords_url }
      format.json { head :ok }
    end
  end

  private
  def authenticate
     authenticate_or_request_with_http_basic do |id, password| 
         id == KEYWORDS_ID && password == KEYWORDS_PASS
     end
  end


end