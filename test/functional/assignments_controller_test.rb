require 'test_helper'

class AssignmentsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:assignments)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_assignment
    assert_difference('Assignment.count') do
      post :create, :assignment => { }
    end

    assert_redirected_to assignment_path(assigns(:assignment))
  end

  def test_should_show_assignment
    get :show, :id => assignments(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => assignments(:one).id
    assert_response :success
  end

  def test_should_update_assignment
    put :update, :id => assignments(:one).id, :assignment => { }
    assert_redirected_to assignment_path(assigns(:assignment))
  end

  def test_should_destroy_assignment
    assert_difference('Assignment.count', -1) do
      delete :destroy, :id => assignments(:one).id
    end

    assert_redirected_to assignments_path
  end
end
