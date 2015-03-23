module Origin
  module Extensions
  # This module contains additional object behaviour.
  module Set
  module ClassMethods
  # Evolve the set, casting all its elements.
  def evolve(object)
  return object if !object || !object.respond_to?(:map)
  object.map{ |obj| obj.class.evolve(obj) }
  end
  end
  end
  end
end
::Set.__send__(:extend, Origin::Extensions::Set::ClassMethods)