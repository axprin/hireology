require_relative 'organization'

class OrganizationTree
	attr_accessor :organizations
	def initialize
		@organizations = []
	end

	def print_all_access_levels
		@org_names = []
		@access_levels = []
		@organizations.each do |org|
			@org_names << org.name
			@access_levels << org.has_access_to
		end
		Hash[@org_names.zip(@access_levels)]
	end

	def find_root_org
		@organizations.each do |org|
			if org.parent == nil
				@root_org = org
			end
		end
		@root_org
	end

	def add_org(args)
		@new_org = Organization.new(name: args[:name])
		@new_org.add_parent(args[:parent])
		@new_org.add_child(args[:child])
		@new_org.set_access_level(args[:access_level])
		@organizations << @new_org
	end

end
