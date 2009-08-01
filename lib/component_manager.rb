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
      desc[:componentType]         = hash[:type].to_ostype
      desc[:componentSubType]      = hash[:sub_type].to_ostype
      desc[:componentManufacturer] = hash[:manufacturer].to_ostype
      desc[:componentFlags]        = hash.fetch(:flags, 0)
      desc[:componentFlagsMask]    = hash.fetch(:flags_mask, 0)
      desc
    end
  end
end
