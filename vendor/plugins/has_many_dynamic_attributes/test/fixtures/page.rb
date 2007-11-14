class Page < ActiveRecord::Base
  has_flex_attributes
  validates_presence_of :intro
end