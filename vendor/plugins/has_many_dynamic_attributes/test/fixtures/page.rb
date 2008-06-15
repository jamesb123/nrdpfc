class Page < ActiveRecord::Base
  has_many_dynamic_attributes
  validates_presence_of :intro
end