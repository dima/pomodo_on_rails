class AssignmentsController < ApplicationController
  # GET /assignments
  # GET /assignments.xml
  # GET /assignments.fxml
  def index
    @assignments = Assignment.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assignments }
      format.fxml  { render :fxml => @assignments }
    end
  end

  # GET /assignments/1
  # GET /assignments/1.xml
  # GET /assignments/1.fxml
  def show
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assignment }
      format.fxml  { render :fxml => @assignment }
    end
  end

  # GET /assignments/new
  # GET /assignments/new.xml
  def new
    @assignment = Assignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.xml
  # POST /assignments.fxml
  def create
    @assignment = Assignment.new(params[:assignment])

    respond_to do |format|
      if @assignment.save
        flash[:notice] = 'Assignment was successfully created.'
        format.html { redirect_to(@assignment) }
        format.xml  { render :xml => @assignment, :status => :created, :location => @assignment }
        format.fxml  { render :fxml => @assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
        format.fxml  { render :fxml => @assignment.errors }
      end
    end
  end

  # PUT /assignments/1
  # PUT /assignments/1.xml
  # PUT /assignments/1.fxml
  def update
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        flash[:notice] = 'Assignment was successfully updated.'
        format.html { redirect_to(@assignment) }
        format.xml  { head :ok }
        format.fxml  { render :fxml => @assignment }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
        format.fxml  { render :fxml => @assignment.errors }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.xml
  # DELETE /assignments/1.fxml
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to(assignments_url) }
      format.xml  { head :ok }
      format.fxml  { render :fxml => @assignment }
    end
  end
end