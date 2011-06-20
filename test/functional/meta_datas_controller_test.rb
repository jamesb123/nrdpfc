require 'test_helper'

class MetaDatasControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:meta_datas)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_meta_data
    assert_difference('MetaData.count') do
      post :create, :meta_data => { }
    end

    assert_redirected_to meta_data_path(assigns(:meta_data))
  end

  def test_should_show_meta_data
    get :show, :id => meta_datas(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => meta_datas(:one).id
    assert_response :success
  end

  def test_should_update_meta_data
    put :update, :id => meta_datas(:one).id, :meta_data => { }
    assert_redirected_to meta_data_path(assigns(:meta_data))
  end

  def test_should_destroy_meta_data
    assert_difference('MetaData.count', -1) do
      delete :destroy, :id => meta_datas(:one).id
    end

    assert_redirected_to meta_datas_path
  end
end
