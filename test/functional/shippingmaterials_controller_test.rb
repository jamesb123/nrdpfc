require File.dirname(__FILE__) + '/../test_helper'
require 'shippingmaterials_controller'

# Re-raise errors caught by the controller.
# class ShippingmaterialsController; def rescue_action(e) raise e end; end
# 
# class ShippingmaterialsControllerTest < Test::Unit::TestCase
#  fixtures :shippingmaterials
#
#  def setup
#    @controller = ShippingmaterialsController.new
#    @request    = ActionController::TestRequest.new
#    @response   = ActionController::TestResponse.new
#
#    @first_id = shippingmaterials(:first).id
#  end
#
#  def test_index
#    get :index
#    assert_response :success
#    assert_template 'list'
#  end
#
#  def test_list
#    get :list
#
#    assert_response :success
#    assert_template 'list'
#
#    assert_not_nil assigns(:shippingmaterials)
#  end
#
#  def test_show
#    get :show, :id => @first_id
#
#    assert_response :success
#    assert_template 'show'
#
#    assert_not_nil assigns(:shippingmaterial)
#    assert assigns(:shippingmaterial).valid?
#  end
#
#  def test_new
#    get :new
#
#    assert_response :success
#    assert_template 'new'
#
#    assert_not_nil assigns(:shippingmaterial)
#  end
#
#  def test_create
#    num_shippingmaterials = Shippingmaterial.count
#
#    post :create, :shippingmaterial => {}
#
#    assert_response :redirect
#    assert_redirected_to :action => 'list'
#
#    assert_equal num_shippingmaterials + 1, Shippingmaterial.count
#  end
#
#  def test_edit
#    get :edit, :id => @first_id
#
#    assert_response :success
#    assert_template 'edit'
#
#    assert_not_nil assigns(:shippingmaterial)
#    assert assigns(:shippingmaterial).valid?
#  end
#
#  def test_update
#    post :update, :id => @first_id
#    assert_response :redirect
#    assert_redirected_to :action => 'show', :id => @first_id
#  end
#
#  def test_destroy
#    assert_nothing_raised {
#      Shippingmaterial.find(@first_id)
#    }
#
#    post :destroy, :id => @first_id
#    assert_response :redirect
#    assert_redirected_to :action => 'list'
#
#    assert_raise(ActiveRecord::RecordNotFound) {
#      Shippingmaterial.find(@first_id)
#    }
#  end
# end
