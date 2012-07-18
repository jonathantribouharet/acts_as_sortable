module ActiveRecord; module Acts; end; end
module ActiveRecord::Acts::ActsAsSortable
  
	def self.included(klass)
		klass.class_eval do
			class_attribute :acts_as_sortable_scope
			extend(ClassMethods)
		end
	end
	
	module ClassMethods
	
		def acts_as_sortable(&block)
		
			include ActiveRecord::Acts::ActsAsSortable::InstanceMethods
			
			yield self if block_given?
			
			attr_protected :position
			self.default_scope order('"' + self.table_name + '"."position" ASC')
			
			before_create do
				if self.class.last.nil?
					self.position = 0
				else
					self.position = self.class.last.position + 1 
				end
				
				true
			end

		end	
	end

	module InstanceMethods
				
		def position_up!
			ActiveRecord::Base.transaction do
				scope = self.class.where(['position < ?', self.position])
				scope = scope.where(self.class.acts_as_sortable_scope => self.send(self.class.acts_as_sortable_scope)) if self.class.acts_as_sortable_scope
				next_element = scope.last
				
				if next_element
					temp_position = next_element.position
					next_element.position = self.position
					next_element.save!(:validates => false)
					self.position = temp_position
					self.save!(:validates => false)
				end
			end
		end
				
		def position_down!			
			ActiveRecord::Base.transaction do
				
				scope = self.class.where(['position > ?', self.position])
				scope = scope.where(self.class.acts_as_sortable_scope => self.send(self.class.acts_as_sortable_scope)) if self.class.acts_as_sortable_scope
				prev_element = scope.first
				
				if prev_element
					temp_position = prev_element.position
					prev_element.position = self.position
					prev_element.save!(:validates => false)
					self.position = temp_position
					self.save!(:validates => false)
				end				
			end
		end
				
	end

end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::ActsAsSortable)
