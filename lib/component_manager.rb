module ComponentManager
  MAC_ERRORS[-2005] = "Bad component type"
  
  class ComponentDescription < FFI::Struct
    layout :componentType,         :uint32,
           :componentSubType,      :uint32,
           :componentManufacturer, :uint32,
           :componentFlags,        :ulong,
           :componentFlagsMask,    :ulong
  end
end
