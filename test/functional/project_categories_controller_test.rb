require 'test_helper'

class ProjectCategoriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:project_categories)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_project_category
    assert_difference('ProjectCategory.count') do
      post :create, :project_category => { }
    end

    assert_redirected_to project_category_path(assigns(:project_category))
  end

  def test_should_show_project_category
    get :show, :id => project_categories(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => project_categories(:one).id
    assert_response :success
  end

  def test_should_update_project_category
    put :update, :id => project_categories(:one).id, :project_category => { }
    assert_redirected_to project_category_path(assigns(:project_category))
  end

  def test_should_destroy_project_category
    assert_difference('ProjectCategory.count', -1) do
      delete :destroy, :id => project_categories(:one).id
    end

    assert_redirected_to project_categories_path
  end
end
