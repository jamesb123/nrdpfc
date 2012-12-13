class ChangeSamplesCommentsMemo < ActiveRecord::Migration
  def self.up
    change_column :samples, :comments, :text
  end

  def self.down
    change_column :samples, :comments, :string
  end
end
