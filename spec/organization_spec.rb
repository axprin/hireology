require_relative 'spec_helper'

describe "Organization" do
  let(:org){Organization.new(name: "Test1")}
  let(:root_org){Organization.new(name: "Test2")}
  let(:child_org){Organization.new(name: "Test3")}

  it "should respond to name" do
    expect(org).to respond_to(:name)
  end

  it "should respond to parent" do
    expect(org).to respond_to(:parent)
  end
  
  it "should respond to children" do
    expect(org).to respond_to(:children)
  end
  
  it "should respond to access_level" do
    expect(org).to respond_to(:access_level)
  end

   it "should respond to org_type" do
    expect(org).to respond_to(:org_type)
  end

  describe "update_name" do
    it "should be able to change the Organization name" do
      org.update_name("Test Org")
      root_org.update_name("Root Org")
      child_org.update_name("Child Org")
      expect(org.name).to eq("Test Org")
      expect(root_org.name).to eq("Root Org")
      expect(child_org.name).to eq("Child Org")
    end
  end
  
  describe "access_level" do
    it "should set the access_level to User upon creation" do
      expect(org.access_level).to eq("User")
      expect(root_org.access_level).to eq("User")
      expect(child_org.access_level).to eq("User")
    end
  end

  describe "set_access_level" do
    it "should update the access_level" do
      root_org.set_access_level("Admin")
      expect(root_org.access_level).to eq("Admin")
    	org.set_access_level("User")
      expect(org.access_level).to eq("User")
    end
  end

  describe "add_parent" do
    it "should set the parent org" do
    	org.add_parent("Root Org")
    	child_org.add_parent("Test Org")
      expect(org.parent).to eq("Root Org")
      expect(child_org.parent).to eq("Test Org")
    end
  end

  describe "add_child" do
    it "should set the Child orgs" do
    	root_org.add_child(org)
    	org.add_child(child_org)
      expect(root_org.children).to eq([org])
      expect(org.children).to eq([child_org])
    end
  end

  describe "has_access_to" do
  let(:root){Organization.new(name:"Root", parent:nil, children:[org1,org2], access_level:"Admin", org_type:"Root Org")}
  let(:org1){Organization.new(name:"Org1", parent:"Root", children:[child1, child2], access_level:"Admin", org_type:"Org")}
  let(:child1){Organization.new(name:"Child1", parent:"Org1", children:nil, access_level:"Admin", org_type:"Child Org")}
  let(:child2){Organization.new(name:"Child2", parent:"Org1", children:nil, access_level:"Denied", org_type:"Child Org")}
  let(:org2){Organization.new(name:"Org2", parent:"Root", children:[], access_level:"User", org_type:"Org")}    
    it "should return all accesses for the org" do
      expect(child2.has_access_to).to eq(child2)
      expect(root.has_access_to).to eq(root)
    end
  end

  describe "inherit_permission" do
  let(:ip_test1){Organization.new(name:"test1")}
  let(:ip_test2){Organization.new(name:"test2")}
  let(:ip_test3){Organization.new(name:"test3")}  
  	it "should pull the access level from the parent org (Admin)" do
  		ip_test1.add_parent(Organization.new(name:"test1",access_level:"Admin"))
  		ip_test1.inherit_permission
  		expect(ip_test1.access_level).to eq("Admin")
  	end
  	it "should pull the access level from the parent org (User)" do
  		ip_test2.add_parent(Organization.new(name:"test2",access_level:"User"))
  		ip_test2.inherit_permission
  		expect(ip_test2.access_level).to eq("User")
  	end
  	it "should pull the access level from the parent org (Denied)" do
  		ip_test3.add_parent(Organization.new(name:"test3",access_level:"Denied"))
  		ip_test3.inherit_permission
  		expect(ip_test3.access_level).to eq("User")
  	end
  end


end