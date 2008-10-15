class AccountMailer < ActionMailer::Base
  def signup_notification(account)
    setup_email(account)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://localhost:3000/activate/#{account.activation_code}"
  
  end
  
  def activation(account)
    setup_email(account)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://localhost:3000/"
  end
  
  protected
    def setup_email(account)
      @recipients  = "#{account.email}"
      @from        = "Administrator"
      @subject     = "[pomodo] "
      @sent_on     = Time.now
      @body[:account] = account
    end
end
