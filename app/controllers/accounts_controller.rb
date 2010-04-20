class AccountsController < ApplicationController
  skip_before_filter :login_required, :except => :update
    
  # Protect these actions behind an admin login
  before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_account, :only => [:suspend, :unsuspend, :destroy, :purge]
  
  # render new.rhtml
  def new
    @account = Account.new
  end
 
  def create
    logout_keeping_session!
    @account = Account.new(params[:account])
    @account.register! if @account && @account.valid?
    success = @account && @account.valid?
    if success && @account.errors.empty?
      respond_to do |format|
        format.html do
          redirect_back_or_default('/')
          flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
        end
        format.fxml { render :fxml => @account.to_fxml(:only => [:id, :name, :login, :email]) }
        format.xml  { render :xml => @account.to_xml(:only => [:id, :name, :login, :email]), 
          :status => :created, :location => @account }
        format.amf  { render :amf => @account.to_amf(:only => [:id, :name, :login, :email]) }
      end
    else
      respond_to do |format|
        format.html do
          flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
          render :action => 'new'
        end
        format.fxml { render :fxml => @account.errors }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
        format.amf  { render :amf => @account.errors }
      end
    end
  end

  def activate
    logout_keeping_session!
    account = Account.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && account && !account.active?
      account.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a account with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

  def suspend
    @account.suspend! 
    redirect_to accounts_path
  end

  def unsuspend
    @account.unsuspend! 
    redirect_to accounts_path
  end

  def destroy
    @account.delete!
    redirect_to accounts_path
  end

  def purge
    @account.destroy
    redirect_to accounts_path
  end
  
  
  # There's no page here to update or destroy a account.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.
  
  # TODO: add old password checking and only update name, email and password fields
  def update
    @account = Account.current_account    
    respond_to do |format|
      if @account.update_attributes(params[:account])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
        format.fxml { render :fxml => @account.to_fxml(:only => [:id, :name, :login, :email],
          :methods => [:photo_url]) }
        format.amf  { render :amf => @account.to_amf(:only => [:id, :name, :login, :email], 
          :methods => [:photo_url]) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
        format.fxml { render :fxml => @account.errors }
        format.amf  { render :amf => @account.errors }
      end
    end
  end

protected
  def find_account
    @account = Account.find(params[:id])
  end
end
