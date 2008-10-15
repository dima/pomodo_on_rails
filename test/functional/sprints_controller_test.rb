require 'test_helper'

class SprintsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:sprints)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_sprint
    assert_difference('Sprint.count') do
      post :create, :sprint => { }
    end

    assert_redirected_to sprint_path(assigns(:sprint))
  end

  def test_should_show_sprint
    get :show, :id => sprints(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => sprints(:one).id
    assert_response :success
  end

  def test_should_update_sprint
    put :update, :id => sprints(:one).id, :sprint => { }
    assert_redirected_to sprint_path(assigns(:sprint))
  end

  def test_should_destroy_sprint
    assert_difference('Sprint.count', -1) do
      delete :destroy, :id => sprints(:one).id
    end

    assert_redirected_to sprints_path
  end
end
