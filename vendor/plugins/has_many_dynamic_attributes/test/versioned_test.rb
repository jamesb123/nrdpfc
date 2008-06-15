require 'test/unit'
require File.join(File.dirname(__FILE__), 'test_helper')

# TODO - These tests were written for a very different version of this plugin (flex-attributes).  Needs to be updated

# We don't want to do a full test on the capabilites of versioning. That is the
# responsibility of acts_as_versioned and acts_as_versioned_association.
# Instead we just want to ensure that versioned support can be installed
# and that flex_attributes are accessible
class VersionedTest < Test::Unit::TestCase

  def test_model_versions_attributes_on_save

    # Create a document and make changes
    resume = Document.new :name => 'Resume'
    resume.copyright_attr = '2005 Eric Anderson'
    resume.save!
    resume.copyright_attr = '2006 Eric Anderson'
    resume.save!
    resume.copyright_attr = '2006 Foobar Corp'
    resume.save!
    resume.versions(true)

    assert_equal '2006 Eric Anderson', resume.versions[1].copyright_attr
    assert_equal '2005 Eric Anderson', resume.versions[0].copyright_attr
  end
end