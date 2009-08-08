require 'ffi'

module FFI
  
  class Pointer
    def as_type(type)
      if Class === type && FFI::Struct > type
        type.new(self)
      else
        send(:"read_#{type}")
      end      
    end
  end
  
  module_function
  
  def size_of(type)
    if Class === type && FFI::Struct > type
      type.size
    else
      FFI.type_size(type)
    end    
  end
end
