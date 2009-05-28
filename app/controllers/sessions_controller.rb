# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  
  skip_before_filter :login_required, :verify_authenticity_token   
  
  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    account = Account.authenticate(params[:login], params[:password])
    if account
      self.current_account = account
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
            
      respond_to do |format|
        format.html do
          redirect_back_or_default('/')
          flash[:notice] = "Logged in successfully"
        end
        format.fxml do
          render :fxml => account.user.to_fxml(:methods => :photo, 
            :include => {:address => {}, :account => {:only => [:id, :login, :email, :name], 
              :methods => [:photo_url]}})
        end
        format.xml do 
          render :xml => account.user.to_fxml(:methods => :photo, 
            :include => {:address => {}, :account => {:only => [:id, :login, :email, :name], 
              :methods => [:photo_url]}})
        end
      end
    else
      note_failed_signin
      respond_to do |format|
        format.html do
          @login       = params[:login]
          @remember_me = params[:remember_me]
          render :action => 'new'        
        end
        format.fxml { render :text => "login_failed" }
        format.xml { render :text => "login_failed" }
      end
    end
  end

  def destroy
    logout_killing_session!
    respond_to do |format|
      format.html do
        flash[:notice] = "You have been logged out."
        redirect_back_or_default('/')
      end
      format.fxml { render :text => "loggedout" }
      format.xml { render :text => "loggedout" }
    end
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
