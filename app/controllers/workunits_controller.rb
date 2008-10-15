class WorkunitsController < ApplicationController
  # GET /workunits
  # GET /workunits.xml
  # GET /workunits.fxml
  def index
    @workunits = Workunit.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @workunits }
      format.fxml  { render :fxml => @workunits }
    end
  end

  # GET /workunits/1
  # GET /workunits/1.xml
  # GET /workunits/1.fxml
  def show
    @workunit = Workunit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @workunit }
      format.fxml  { render :fxml => @workunit }
    end
  end

  # GET /workunits/new
  # GET /workunits/new.xml
  def new
    @workunit = Workunit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @workunit }
    end
  end

  # GET /workunits/1/edit
  def edit
    @workunit = Workunit.find(params[:id])
  end

  # POST /workunits
  # POST /workunits.xml
  # POST /workunits.fxml
  def create
    @workunit = Workunit.new(params[:workunit])

    respond_to do |format|
      if @workunit.save
        flash[:notice] = 'Workunit was successfully created.'
        format.html { redirect_to(@workunit) }
        format.xml  { render :xml => @workunit, :status => :created, :location => @workunit }
        format.fxml  { render :fxml => @workunit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @workunit.errors, :status => :unprocessable_entity }
        format.fxml  { render :fxml => @workunit.errors }
      end
    end
  end

  # PUT /workunits/1
  # PUT /workunits/1.xml
  # PUT /workunits/1.fxml
  def update
    @workunit = Workunit.find(params[:id])

    respond_to do |format|
      if @workunit.update_attributes(params[:workunit])
        flash[:notice] = 'Workunit was successfully updated.'
        format.html { redirect_to(@workunit) }
        format.xml  { head :ok }
        format.fxml  { render :fxml => @workunit }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @workunit.errors, :status => :unprocessable_entity }
        format.fxml  { render :fxml => @workunit.errors }
      end
    end
  end

  # DELETE /workunits/1
  # DELETE /workunits/1.xml
  # DELETE /workunits/1.fxml
  def destroy
    @workunit = Workunit.find(params[:id])
    @workunit.destroy

    respond_to do |format|
      format.html { redirect_to(workunits_url) }
      format.xml  { head :ok }
      format.fxml  { render :fxml => @workunit }
    end
  end
end