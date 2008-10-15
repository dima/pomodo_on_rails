class ProjectsController < ApplicationController  
  # GET /projects
  # GET /projects.xml
  # GET /projects.fxml
  def index
    @projects = current_account.user.projects
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
      format.fxml  { render :fxml => @projects.to_fxml(:include => 
        {:sprints => {:include => {:tasks => {:methods => 
          [:total_time, :total_time_today, :total_time_this_week, :total_time_this_month]}}}}) }    
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  # GET /projects/1.fxml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
      format.fxml  { render :fxml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  # POST /projects.fxml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
        format.fxml  { render :fxml => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
        format.fxml  { render :fxml => @project.errors }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  # PUT /projects/1.fxml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
        format.fxml  { render :fxml => @project }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
        format.fxml  { render :fxml => @project.errors }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  # DELETE /projects/1.fxml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
      format.fxml  { render :fxml => @project }
    end
  end
end