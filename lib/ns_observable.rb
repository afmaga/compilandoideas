module NSObservable

	# Extiende ActiveRecord y define una base para todos los
	# objetos observables	
	class ObservableClass < ActiveRecord::Base
		# Evita que lance un error por no existir la tabla
		# asociada con ObservableClass
		class << self
			def table_name
		    	self.name.tableize
		    end
		end
	
		# Reescritura de los filtros after_* o before_*
		after_update  :after_upd_callback
		#after_create  :after_cre_callback
		#after_destroy :after_des_callback
		
		def after_upd_callback
			fire_updated_event
		end
		
		def after_cre_callback
			fire_created_event
		end
		
		def after_des_callback
			fire_destroyed_event
		end
		
		def destroy
      if self.role == "admin"
        self.active = 0
        self.save
      else
        super
      end
		end
		
		def activate
			self.active = 1
			self.save
		end
		
		# Fire's		
		def fire_event(action, options = nil)	
	 		e = Event.create(:params => { "options" => nil })
	 		e.action = action

      
	 		changed
	 		notify_observers(e)
	 	end
		 
		def fire_updated_event(options = nil)
			self.fire_event("updated", options)
		end
		
		def fire_created_event(options = nil)
			self.fire_event("created", options)
		end
		
		def fire_destroyed_event(options = nil)
			self.fire_event("destroyed", options)
		end
		
		
	end
	
end


