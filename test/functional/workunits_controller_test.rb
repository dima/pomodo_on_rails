require 'test_helper'

class WorkunitsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:workunits)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_workunit
    assert_difference('Workunit.count') do
      post :create, :workunit => { }
    end

    assert_redirected_to workunit_path(assigns(:workunit))
  end

  def test_should_show_workunit
    get :show, :id => workunits(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => workunits(:one).id
    assert_response :success
  end

  def test_should_update_workunit
    put :update, :id => workunits(:one).id, :workunit => { }
    assert_redirected_to workunit_path(assigns(:workunit))
  end

  def test_should_destroy_workunit
    assert_difference('Workunit.count', -1) do
      delete :destroy, :id => workunits(:one).id
    end

    assert_redirected_to workunits_path
  end
end
