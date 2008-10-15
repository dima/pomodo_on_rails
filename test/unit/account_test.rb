require File.dirname(__FILE__) + '/../test_helper'

class AccountTest < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper
  fixtures :accounts

  def test_should_create_account
    assert_difference 'Account.count' do
      account = create_account
      assert !account.new_record?, "#{account.errors.full_messages.to_sentence}"
    end
  end

  def test_should_initialize_activation_code_upon_creation
    account = create_account
    account.reload
    assert_not_nil account.activation_code
  end

  def test_should_create_and_start_in_pending_state
    account = create_account
    account.reload
    assert account.pending?
  end


  def test_should_require_login
    assert_no_difference 'Account.count' do
      u = create_account(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'Account.count' do
      u = create_account(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'Account.count' do
      u = create_account(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'Account.count' do
      u = create_account(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    accounts(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal accounts(:quentin), Account.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    accounts(:quentin).update_attributes(:login => 'quentin2')
    assert_equal accounts(:quentin), Account.authenticate('quentin2', 'monkey')
  end

  def test_should_authenticate_account
    assert_equal accounts(:quentin), Account.authenticate('quentin', 'monkey')
  end

  def test_should_set_remember_token
    accounts(:quentin).remember_me
    assert_not_nil accounts(:quentin).remember_token
    assert_not_nil accounts(:quentin).remember_token_expires_at
  end

  def test_should_unset_remember_token
    accounts(:quentin).remember_me
    assert_not_nil accounts(:quentin).remember_token
    accounts(:quentin).forget_me
    assert_nil accounts(:quentin).remember_token
  end

  def test_should_remember_me_for_one_week
    before = 1.week.from_now.utc
    accounts(:quentin).remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil accounts(:quentin).remember_token
    assert_not_nil accounts(:quentin).remember_token_expires_at
    assert accounts(:quentin).remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc
    accounts(:quentin).remember_me_until time
    assert_not_nil accounts(:quentin).remember_token
    assert_not_nil accounts(:quentin).remember_token_expires_at
    assert_equal accounts(:quentin).remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    before = 2.weeks.from_now.utc
    accounts(:quentin).remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil accounts(:quentin).remember_token
    assert_not_nil accounts(:quentin).remember_token_expires_at
    assert accounts(:quentin).remember_token_expires_at.between?(before, after)
  end

  def test_should_register_passive_account
    account = create_account(:password => nil, :password_confirmation => nil)
    assert account.passive?
    account.update_attributes(:password => 'new password', :password_confirmation => 'new password')
    account.register!
    assert account.pending?
  end

  def test_should_suspend_account
    accounts(:quentin).suspend!
    assert accounts(:quentin).suspended?
  end

  def test_suspended_account_should_not_authenticate
    accounts(:quentin).suspend!
    assert_not_equal accounts(:quentin), Account.authenticate('quentin', 'test')
  end

  def test_should_unsuspend_account_to_active_state
    accounts(:quentin).suspend!
    assert accounts(:quentin).suspended?
    accounts(:quentin).unsuspend!
    assert accounts(:quentin).active?
  end

  def test_should_unsuspend_account_with_nil_activation_code_and_activated_at_to_passive_state
    accounts(:quentin).suspend!
    Account.update_all :activation_code => nil, :activated_at => nil
    assert accounts(:quentin).suspended?
    accounts(:quentin).reload.unsuspend!
    assert accounts(:quentin).passive?
  end

  def test_should_unsuspend_account_with_activation_code_and_nil_activated_at_to_pending_state
    accounts(:quentin).suspend!
    Account.update_all :activation_code => 'foo-bar', :activated_at => nil
    assert accounts(:quentin).suspended?
    accounts(:quentin).reload.unsuspend!
    assert accounts(:quentin).pending?
  end

  def test_should_delete_account
    assert_nil accounts(:quentin).deleted_at
    accounts(:quentin).delete!
    assert_not_nil accounts(:quentin).deleted_at
    assert accounts(:quentin).deleted?
  end

protected
  def create_account(options = {})
    record = Account.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.register! if record.valid?
    record
  end
end
