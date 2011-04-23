module Acts
  module AsPickable

    def self.included(base)
      base.extend AddActsAsMethod
    end

    module AddActsAsMethod

      def acts_as_pickable(column = :picked)
        class_eval <<-END
          after_create :set_as_picked
          after_destroy :pick_new_one
          include Acts::AsPickable::InstanceMethods
        END

        cattr_accessor :pickable_column
        self.pickable_column = column
      end
    end

    module InstanceMethods

      def self.included(aClass)
        aClass.extend ClassMethods
      end
      
      module ClassMethods

        # Select new picked element
        def new_picked
          c = self.count
          return nil if c == 0
          if c == 1
            return self.first
          end

          self.all.each do |q|
            q.send("#{self.pickable_column}=",false)
            q.save
          end

          s = self.random

          s.send("#{self.pickable_column}=",true)
          s.save
          s
        end

        def random(skip_cache = false)
          if ActiveRecord::Base.connection.adapter_name == 'SQLite'
            rand = "Random()"
          else
            rand = "Rand()"
          end

          unless skip_cache
            order(rand).first
          else
            uncached do
              order(rand).first
            end
          end
        end

        def picked
          self.where(self.pickable_column => true).first
        end

      end

      # Sets current object as picked
      def set_as_picked
        self.class.where(self.class.pickable_column => true).each  do |q|
          if q.send(self.class.pickable_column)
            q.send("#{self.class.pickable_column}=", false)
            q.save
          end
        end
        self.send("#{self.class.pickable_column}=", true)
        self.save
      end

      private

      def pick_new_one
        if self.send(self.class.pickable_column)
          self.class.where("id <> ?", self.id).first.set_as_picked if self.class.count > 0
        end
      end

    end
  end
end

ActiveRecord::Base.send(:include, Acts::AsPickable)
