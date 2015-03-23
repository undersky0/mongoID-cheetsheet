module Mongoid
  module Extensions
    module Set
      
        def mongoize
        ::Set.mongoize(self)
        end
        
        module ClassMethods
        def demongoize(object)
        ::Set.new(object)
        end
        def mongoize(object)
        object.to_a
        end
        
      end
    end
  end
end
::Set.__send__(:include, Mongoid::Extensions::Set)
::Set.__send__(:extend, Mongoid::Extensions::Set::ClassMethods)