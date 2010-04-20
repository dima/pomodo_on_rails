class ProjectCategoriesController < ApplicationController
  skip_before_filter :login_required, :only => :index
  
  # GET /project_categories
  # GET /project_categories.xml
  # GET /project_categories.fxml
  def index
    @project_categories = ProjectCategory.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @project_categories }
      format.fxml { render :fxml => @project_categories }
      format.amf  { render :amf => @project_categories }
    end
  end

  # GET /project_categories/1
  # GET /project_categories/1.xml
  # GET /project_categories/1.fxml
  def show
    @project_category = ProjectCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project_category }
      format.fxml { render :fxml => @project_category }
      format.amf  { render :amf => @project_category }
    end
  end

  # GET /project_categories/new
  # GET /project_categories/new.xml
  def new
    @project_category = ProjectCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project_category }
    end
  end

  # GET /project_categories/1/edit
  def edit
    @project_category = ProjectCategory.find(params[:id])
  end

  # POST /project_categories
  # POST /project_categories.xml
  # POST /project_categories.fxml
  def create
    @project_category = ProjectCategory.new(params[:project_category])

    respond_to do |format|
      if @project_category.save
        flash[:notice] = 'ProjectCategory was successfully created.'
        format.html { redirect_to(@project_category) }
        format.xml  { render :xml => @project_category, :status => :created, :location => @project_category }
        format.fxml { render :fxml => @project_category }
        format.amf  { render :amf => @project_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project_category.errors, :status => :unprocessable_entity }
        format.fxml { render :fxml => @project_category.errors }
        format.amf  { render :amf => @project_category.errors }
      end
    end
  end

  # PUT /project_categories/1
  # PUT /project_categories/1.xml
  # PUT /project_categories/1.fxml
  def update
    @project_category = ProjectCategory.find(params[:id])

    respond_to do |format|
      if @project_category.update_attributes(params[:project_category])
        flash[:notice] = 'ProjectCategory was successfully updated.'
        format.html { redirect_to(@project_category) }
        format.xml  { head :ok }
        format.fxml { render :fxml => @project_category }
        format.amf { render :amf => @project_category }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project_category.errors, :status => :unprocessable_entity }
        format.fxml { render :fxml => @project_category.errors }
        format.amf  { render :amf => @project_category.errors }
      end
    end
  end

  # DELETE /project_categories/1
  # DELETE /project_categories/1.xml
  # DELETE /project_categories/1.fxml
  def destroy
    @project_category = ProjectCategory.find(params[:id])
    @project_category.destroy

    respond_to do |format|
      format.html { redirect_to(project_categories_url) }
      format.xml  { head :ok }
      format.fxml { render :fxml => @project_category }
      format.amf  { render :amf => @project_category }
    end
  end
end