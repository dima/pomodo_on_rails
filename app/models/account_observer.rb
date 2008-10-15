class AccountObserver < ActiveRecord::Observer
  def after_create(account)
    AccountMailer.deliver_signup_notification(account)
    
    address = Address.new
    address.save!
    
    user = User.new
    user.account = account
    user.address = address
    user.save!
  end

  def after_save(account)
    AccountMailer.deliver_activation(account) if account.recently_activated?
  end
end
