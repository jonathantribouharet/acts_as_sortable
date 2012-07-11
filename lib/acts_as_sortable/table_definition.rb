module ActiveRecord; module ConnectionAdapters; end; end
module ActiveRecord::ConnectionAdapters::ActsAsSortableTableDefinition
	
	def position
		column :position, :integer, :null => false
	end
	
end

ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, ActiveRecord::ConnectionAdapters::ActsAsSortableTableDefinition)
