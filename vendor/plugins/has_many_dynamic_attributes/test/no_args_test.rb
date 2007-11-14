require 'test/unit'
require File.join(File.dirname(__FILE__), 'test_helper')

class NoArgsTest < Test::Unit::TestCase
  fixtures :pages, :page_attributes

  # Make sure the has_many relationship is formed correctly
  def test_has_many_relationship
    pa = Page.find_by_name('Home Page').page_attributes
    assert_instance_of PageAttribute, pa[0]
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
    home_page = Page.find_by_name 'Home Page'
    assert_equal 'Foo Bar Industries gets two thumbs up', home_page['comment']
    assert_equal 'We deliver quality foobars to consumers nationwide and around the globe',
      home_page['intro']
    assert_equal 'Coming October 7, the foobarantator', home_page['teaser']
  end

  def test_method_missing_read
    home_page = Page.find_by_name 'Home Page'
    assert_equal 'Foo Bar Industries gets two thumbs up', home_page.comment
    assert_equal 'We deliver quality foobars to consumers nationwide and around the globe',
      home_page.intro
    assert_equal 'Coming October 7, the foobarantator', home_page.teaser
  end

  def test_read_attribute_not_exist
    home_page = Page.find_by_name 'Home Page'
    assert_nil home_page.send(:read_attribute, 'not_exist')
  end

  def test_write_attribute
    home_page = Page.find_by_name 'Home Page'
    home_page.send :write_attribute, 'intro', 'Blah Blah Blah'
    assert_equal 'Blah Blah Blah', home_page.send(:read_attribute, 'intro')
    assert_not_equal 'Blah Blah Blah', PageAttribute.find(2).value
    home_page.save!
    assert_equal 'Blah Blah Blah', PageAttribute.find(2).value
  end

  def test_delete_attribute
    home_page = Page.find_by_name 'Home Page'
    home_page.send :write_attribute, 'comment', nil
    comment = home_page.page_attributes.find_by_name 'comment'
    assert_not_nil comment
    assert_nil home_page.send(:read_attribute, 'comment')
    home_page.save!
    assert_nil home_page.send(:read_attribute, 'comment')
    comment = home_page.page_attributes.find_by_name 'comment'
    assert_nil home_page.send(:read_attribute, 'comment')
    assert_nil PageAttribute.find_by_id(1)
  end

  def test_create_attribute
    home_page = Page.find_by_name 'Home Page'
    home_page.send :write_attribute, 'new_attribute', 'new_value'
    new_attribute = home_page.page_attributes.to_a.find {|a| a.name == 'new_attribute'}
    assert_not_nil new_attribute
    assert_equal 'new_value', home_page.send(:read_attribute, 'new_attribute')
    assert_nil PageAttribute.find_by_name_and_page_id('new_attribute', 1)
    home_page.save!
    assert_equal 'new_value',
      PageAttribute.find_by_name_and_page_id('new_attribute', 1).value
    assert_equal 'new_value', home_page.send(:read_attribute, 'new_attribute')
  end
end
