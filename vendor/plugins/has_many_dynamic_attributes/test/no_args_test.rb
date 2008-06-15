require 'test/unit'
require File.join(File.dirname(__FILE__), 'test_helper')

class NoArgsTest < Test::Unit::TestCase
  fixtures :pages, :dynamic_attributes, :dynamic_attribute_values, :dynamic_types #, :page_attributes

  # Make sure the has_many relationship is formed correctly
  def test_has_many_relationship
    pa = Page.find_by_name('Home Page').dynamic_attribute_values
    assert_instance_of DynamicAttributeValue, pa[0]
    assert_equal 3, pa.size
  end

  def test_read_attribute
    home_page = Page.find_by_name 'Home Page'
    assert_equal 'Foo Bar Industries gets two thumbs up',
      home_page.send(:read_attribute, 'comment')
    assert_equal 'We deliver quality foobars to consumers nationwide and around the globe',
      home_page.send(:read_attribute, 'intro')
    assert_equal 'Coming October 7, the foobarantator',
      home_page.send(:read_attribute, 'teaser')
  end

  def test_bracket_read
    home_page = Page.find_by_name('Home Page')
    assert_equal 'Foo Bar Industries gets two thumbs up'                                   , home_page['comment']
    assert_equal 'We deliver quality foobars to consumers nationwide and around the globe' , home_page['intro']
    assert_equal 'Coming October 7, the foobarantator'                                     , home_page['teaser']
  end

  def test_method_missing_read
    home_page = Page.find_by_name 'Home Page'
    assert_equal 'Foo Bar Industries gets two thumbs up'                                   , home_page.comment
    assert_equal 'We deliver quality foobars to consumers nationwide and around the globe' , home_page.intro
    assert_equal 'Coming October 7, the foobarantator'                                     , home_page.teaser
  end

  def test_read_attribute_not_exist
    home_page = Page.find_by_name 'Home Page'
    assert_nil home_page.send(:read_attribute, 'not_exist')
  end

  def test_update_attribute
    @dynamic_attribute_value = dynamic_attribute_values(:home_page_intro)
    home_page = Page.find_by_name 'Home Page'
    home_page.send :write_attribute, 'intro', 'Blah Blah Blah'
    assert_equal 'Blah Blah Blah', home_page.send(:read_attribute, 'intro')
    @dynamic_attribute_value.reload
    assert_not_equal 'Blah Blah Blah', @dynamic_attribute_value.text_value
    home_page.save!
    @dynamic_attribute_value.reload
    assert_equal 'Blah Blah Blah', @dynamic_attribute_value.text_value
  end
  
  # This is no longer how it behaves
  # def test_delete_attribute
  #   comment = dynamic_attribute_values(:home_page_comment)
  #   
  #   home_page = Page.find_by_name 'Home Page'
  #   home_page.send :write_attribute, 'comment', nil
  #   
  #   assert DynamicAttributeValue.find_by_id(comment.id)
  #   assert_nil home_page.send(:read_attribute, 'comment')
  #   home_page.save!
  #   assert_nil home_page.send(:read_attribute, 'comment')
  #   assert_nil DynamicAttributeValue.find_by_id(comment.id)
  # end

  def test_create_attribute
    @new_value = 'this is totally awesome!'
    home_page = Page.create(:name => 'New page') 
    home_page.send :write_attribute, 'intro', @new_value;
    new_attribute = home_page.dynamic_attribute_values.detect { |a| a.dynamic_attribute.name == 'intro'}
    assert_not_nil new_attribute
    assert_equal @new_value, home_page.send(:read_attribute, 'intro')
  end
end
