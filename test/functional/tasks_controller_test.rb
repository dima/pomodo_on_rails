require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_task
    assert_difference('Task.count') do
      post :create, :task => { }
    end

    assert_redirected_to task_path(assigns(:task))
  end

  def test_should_show_task
    get :show, :id => tasks(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => tasks(:one).id
    assert_response :success
  end

  def test_should_update_task
    put :update, :id => tasks(:one).id, :task => { }
    assert_redirected_to task_path(assigns(:task))
  end

  def test_should_destroy_task
    assert_difference('Task.count', -1) do
      delete :destroy, :id => tasks(:one).id
    end

    assert_redirected_to tasks_path
  end
end
