require 'test/unit'
require File.join(File.dirname(__FILE__), 'test_helper')

# TODO - These tests were written for a very different version of this plugin (flex-attributes).  Needs to be updated
class ValidationTest < Test::Unit::TestCase

  # Make sure the normal validates_XXX work
  def test_validates_presence_of
    page = Page.create :comment => 'No Intro', :teaser => 'This should fail'
    assert_equal "can't be blank", page.errors[:intro]
  end
end