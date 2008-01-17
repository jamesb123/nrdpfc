require File.dirname(__FILE__) + '/../spec_helper'

describe QueryPiece do
  before(:each) do
    @query = QueryPiece.new(
      :select => ["name", "location"],
      :from => "users",
      :join => "LEFT JOIN coso ON (x=y)", 
      :where => ["name = 1", "location = 2"], 
      :having => "name > 0",
      :limit => 10
    )
  end
  
  it "should add up several query pieces" do
    @query += QueryPiece.new(:select => "phone")
    
    @query.select.should == %w[name location phone]
  end
  
  it "should raise an error when trying to add up two SINGLE_ATTRIBUTES" do
    @projects_query = QueryPiece.new(:from => "projects")
    
    lambda { @query += @projects_query }.should raise_error(ArgumentError, "Both source and other have from attributes: users, projects)")
  end
  
  it "should render to sql" do
    @query.to_sql.should == <<EOF
SELECT name, location
FROM users
LEFT JOIN coso ON (x=y)
WHERE (name = 1) AND (location = 2)
HAVING (name > 0)
LIMIT 10
EOF
  end
  
  it "should thrown an error when passing invalid keys" do
    lambda { QueryPiece.new(:sort => "") }.should raise_error(ArgumentError, "Invalid key: :sort")
  end
end
