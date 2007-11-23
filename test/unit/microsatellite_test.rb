require File.dirname(__FILE__) + '/../test_helper'

class MicrosatelliteTest < ActiveSupport::TestCase
  fixtures :projects, :microsatellites
  # Replace this with your real tests.
  def test__update_attributes__should_toggle_recompile_required_field_to_true
    @project = projects(:whale_project)
    @project.recompile_required = false
    assert @project.save
    
    @project.microsatellites.first.update_attributes(:finalResult => true)
    
    @project.reload
    assert @project.recompile_required
  end
end
