require 'test/unit'
require File.join(File.dirname(__FILE__), 'test_helper')

class OptionsTest < Test::Unit::TestCase
  fixtures :users, :preferences, :user_contact_infos

  def test_has_many_on_both
    eric = User.find_by_name('Eric Anderson')

    prefs = eric.preferences
    assert_instance_of Preference, prefs[0]
    assert_equal 2, prefs.size

    contact_info = eric.user_contact_infos
    assert_instance_of UserContactInfo, contact_info[0]
    assert_equal 2, contact_info.size
  end

  def test_fields_restriction_option
    eric = User.find_by_name('Eric Anderson')

    assert_equal 'MyCoolScreenName', eric.aim
    assert_raise NoMethodError do; eric.doesnt_exist end
  end

  def test_flex_attributes_callback
    eric = User.find_by_name('Eric Anderson')

    assert_equal 'name', eric.project_order
    assert_raise NoMethodError do; eric.project_blah end
  end

  def test_is_flex_attributes_callback
    doc = Document.new

    assert_nil doc.copyright_attr
    assert_raise NoMethodError do; doc.no_exist end
  end
end
