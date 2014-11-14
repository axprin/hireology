class Organization
	attr_accessor :name, :parent, :children, :access_level, :org_type
	def initialize(args)
		@name = args[:name]
		@parent = args[:parent]
		@children = args[:children] || []
		@access_level = args[:access_level] || "User"
	end

	def update_name(name)
		@name = name
	end

	def set_access_level(level)
		@access_level = level
	end

	def add_parent(parent)
		@parent = parent
	end

	def add_child(child)
		@children << child
	end

	def inherit_permission
		if self.parent.access_level != "Denied"
			@access_level = self.parent.access_level
		else
			@access_level = "User"
		end
	end

	def update_parent
		if self.access_level == "Admin" || self.access_level == "User"
			if self.parent.children.include?(self)
				self.parent.children << self
			end
		end
	end

	def has_access_to
		my_access = []
		my_access << self
		if @access_level == "Admin"
			@children.each{ |child| my_access << child.has_access_to unless child.access_level == "Denied" } if @children
		end
		my_access[0]
	end
end
