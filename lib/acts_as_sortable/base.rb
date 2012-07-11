module ActiveRecord; module Acts; end; end
module ActiveRecord::Acts::ActsAsSortable
  
	def self.included(klass)
		klass.class_eval do
			extend(ClassMethods)
		end
	end
	
	module ClassMethods
	
		def acts_as_sortable
		
			include ActiveRecord::Acts::ActsAsSortable::InstanceMethods
			
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
				next_element = self.class.where(['position < ?', self.position]).last
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
				prev_element = self.class.where(['position > ?', self.position]).first
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
