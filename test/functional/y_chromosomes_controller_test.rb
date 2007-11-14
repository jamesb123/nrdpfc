require File.dirname(__FILE__) + '/../test_helper'
require 'y_chromosomes_controller'

# Re-raise errors caught by the controller.
class YChromosomesController; def rescue_action(e) raise e end; end

class YChromosomesControllerTest < Test::Unit::TestCase
  fixtures :y_chromosomes

  def setup
    @controller = YChromosomesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = y_chromosomes(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:y_chromosomes)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:y_chromosome)
    assert assigns(:y_chromosome).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:y_chromosome)
  end

  def test_create
    num_y_chromosomes = YChromosome.count

    post :create, :y_chromosome => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_y_chromosomes + 1, YChromosome.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:y_chromosome)
    assert assigns(:y_chromosome).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      YChromosome.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      YChromosome.find(@first_id)
    }
  end
end
