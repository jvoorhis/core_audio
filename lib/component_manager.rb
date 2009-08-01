module ComponentManager
  MAC_ERRORS[-2005] = "Bad component type"
  
  class ComponentDescription < FFI::Struct
    layout :componentType,         :uint32,
           :componentSubType,      :uint32,
           :componentManufacturer, :uint32,
           :componentFlags,        :ulong,
           :componentFlagsMask,    :ulong
    
    def self.from_hash(hash)
      desc = new
      desc[:componentType]         = OSType(hash[:type])
      desc[:componentSubType]      = OSType(hash[:sub_type])
      desc[:componentManufacturer] = OSType(hash[:manufacturer])
      desc[:componentFlags]        = hash.fetch(:flags, 0)
      desc[:componentFlagsMask]    = hash.fetch(:flags_mask, 0)
      desc
    end
  end
end
