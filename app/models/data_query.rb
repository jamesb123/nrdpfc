class DataQuery < ActiveRecord::Base
  belongs_to :project

  serialize :data

  validates_presence_of :data, :project_id

  def before_create
    self.access_key = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{data}--")
  end

  def located_query
    newdata = data.dup

    newdata['samples'] ||= {}
    newdata['samples']['true_longitude'] ||= {}
    newdata['samples']['true_longitude']['select'] = true
    newdata['samples']['true_latitude'] ||= {}
    newdata['samples']['true_latitude']['select'] = true

    newdata
  end

  def self.query_by_key(key)
    obj = find_by_access_key(key)
    unless obj.nil?
      obj.update_attribute(:accessed_at, Time.now) 
      return obj
    end
  end
end
