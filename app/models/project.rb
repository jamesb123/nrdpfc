# == Schema Information
#
# Table name: projects
#
#  id                 :integer(11)   not null, primary key
#  name               :string(255)   
#  code               :string(255)   
#  description        :string(255)   
#  user_id            :integer(11)   
#  recompile_required :boolean(1)    
#

class Project < ActiveRecord::Base
  extend Exportables::ExportableModel

  for table_name in Sample::RESULT_TABLES
    has_many table_name.to_sym
  end
  
  has_many :organisms, :order => "organism_code"
  has_many :samples
  has_many :sample_non_tissues
  has_many :security_settings
  has_many :security_settings
  has_many :microsatellite_horizontals
  has_many :microsatellite_final_horizontals
  has_many :mt_dna_final_horizontals
  has_many :mt_dna_seqs
  has_many :y_chromosome_seqs
  has_many :y_chromosome_final_horizontals
  has_many :y_chromosomes
  has_many :mhc_final_horizontals
  has_many :mhc_seqs
  has_many :gender_final_horizontals
  has_many :dna_results
  has_many :mhc_seqs
  has_many :genders
  has_many :data_querys
  has_many :locus
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  belongs_to :user

  before_create :assign_project_owner
  after_save :assign_default_project
  
  def assign_project_owner
    return true if self.name == "Default"  
    begin
      self.user_id ||= current_user.id
    rescue
      raise "Must be logged in to create a project"
    end
  end
  # This isn't working, I'm not quite sure why...
  # something isn't scoped right...
  def self.is_project_manager?
    user = current_user
    return false if ! user
    return false if ! session[:project_id]
    project = Project.find_by_id(session[:project_id])
    return false if ! project
    @project_manager = (current_project.user_id == current_user.id)
  end

  # if this is the first project created for this user
  # then make it their current (default) project
  def assign_default_project  
    if current_user 
      current_project = self
      current_user.save
    end
  end
  
  # admin can creat projects
  def authorized_for_create?
    current_user.is_admin
  end

  def authorized_for_update?
    current_user.is_admin
  end
  
  def authorized_for_read?
    existing_record_check? ?
      readable_by?(current_user) :
      true # in general they can see the projects
  end

  def readable_by?(user)
    user.authorized_security_for?(self, SecuritySetting::READ_ONLY)
  end

  def authorized_for_destroy?
    return false
    # current_user.is_admin
  end

  def security_setting
    current_user.authorization_display_for(self)
  end

  def flag_for_update
    self.recompile_required = true
    save(false)
  end
  
  def self.flag_for_update(project)
    project = Project.find(project) unless project.is_a?(ActiveRecord::Base)
    project.flag_for_update
  end
  
  def self.current_users_accessible_projects
    current_user && current_user.accessible_projects
  end

  def recompile
    Compiler.compile_project(self)
  end

  def compile_each_organism
    q = Compiler::CompilerBase.organism_query(self)
    q.bulk_records {|org| yield org }
  end
end
