require 'test_helper'

class PackagingsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:packagings)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_packaging
    assert_difference('Packaging.count') do
      post :create, :packaging => { }
    end

    assert_redirected_to packaging_path(assigns(:packaging))
  end

  def test_should_show_packaging
    get :show, :id => packagings(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => packagings(:one).id
    assert_response :success
  end

  def test_should_update_packaging
    put :update, :id => packagings(:one).id, :packaging => { }
    assert_redirected_to packaging_path(assigns(:packaging))
  end

  def test_should_destroy_packaging
    assert_difference('Packaging.count', -1) do
      delete :destroy, :id => packagings(:one).id
    end

    assert_redirected_to packagings_path
  end
end
