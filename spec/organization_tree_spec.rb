require_relative 'spec_helper'

describe "OrganizationTree" do
  let(:org_tree){OrganizationTree.new()}

  it "should respond to organizations" do
    expect(org_tree).to respond_to(:organizations)
  end

  describe "add_org" do
    it "should add a new org to the OrganizationTree" do
      org_tree.add_org({name:"Root", parent:nil, children:[], access_level:"Admin"})
      expect(org_tree.organizations.count).to eq(1)
    end
  end

  describe "find_root_org" do
    let(:root){Organization.new(name:"Root", parent:nil, access_level:"Admin")}
    let(:org1){Organization.new(name:"Org1", parent:root, access_level:"Admin")}
    let(:child1){Organization.new(name:"Child1", parent:org1, children:nil, access_level:"Admin")}
    let(:org_tree2){OrganizationTree.new()}

    it "should find the root org" do
      org_tree2.organizations << root
      org_tree2.organizations << org1
      org_tree2.organizations << child1
      expect(org_tree2.find_root_org).to eq(root)
    end
  end

  # describe "print_all_access_levels" do
  #   let(:root){Organization.new(name:"Root", parent:nil, access_level:"Admin")}
  #   let(:org1){Organization.new(name:"Org1", parent:root, access_level:"Admin")}
  #   let(:child1){Organization.new(name:"Child1", parent:org1, children:nil, access_level:"Admin")}
  #   let(:org_tree2){OrganizationTree.new()}

  #   it "should print all the proper access levels for all orgs" do
  #     org_tree2.print_all_access_levels
  #     expect(org_tree2.print_all_access_levels).to eq(root)
  #   end
  # end
end
