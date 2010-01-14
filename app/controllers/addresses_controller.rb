class AddressesController < ApplicationController
  # GET /addresses
  # GET /addresses.xml
  # GET /addresses.fxml
  def index
    @addresses = Address.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @addresses }
      format.fxml { render :fxml => @addresses }
      format.amf  { render :amf => @addresses }
    end
  end

  # GET /addresses/1
  # GET /addresses/1.xml
  # GET /addresses/1.fxml
  def show
    @address = Address.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @address }
      format.fxml { render :fxml => @address }
      format.amf  { render :amf => @address }
    end
  end

  # GET /addresses/new
  # GET /addresses/new.xml
  def new
    @address = Address.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @address }
    end
  end

  # GET /addresses/1/edit
  def edit
    @address = Address.find(params[:id])
  end

  # POST /addresses
  # POST /addresses.xml
  # POST /addresses.fxml
  def create
    @address = Address.new(params[:address])

    respond_to do |format|
      if @address.save
        flash[:notice] = 'Address was successfully created.'
        format.html { redirect_to(@address) }
        format.xml  { render :xml => @address, :status => :created, :location => @address }
        format.fxml { render :fxml => @address }
        format.amf  { render :amf => @address }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @address.errors, :status => :unprocessable_entity }
        format.fxml { render :fxml => @address.errors }
        format.amf  { render :amf => @address.errors }
      end
    end
  end

  # PUT /addresses/1
  # PUT /addresses/1.xml
  # PUT /addresses/1.fxml
  def update
    @address = Address.find(params[:id])

    respond_to do |format|
      if @address.update_attributes(params[:address])
        flash[:notice] = 'Address was successfully updated.'
        format.html { redirect_to(@address) }
        format.xml  { head :ok }
        format.fxml { render :fxml => @address }
        format.amf  { render :amf => @address }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @address.errors, :status => :unprocessable_entity }
        format.fxml { render :fxml => @address.errors }
        format.amf  { render :amf => @address.errors }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.xml
  # DELETE /addresses/1.fxml
  def destroy
    @address = Address.find(params[:id])
    @address.destroy

    respond_to do |format|
      format.html { redirect_to(addresses_url) }
      format.xml  { head :ok }
      format.fxml { render :fxml => @address }
      format.amf  { render :amf => @address }
    end
  end
end