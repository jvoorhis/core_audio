module ComponentManager
  MAC_ERRORS[-2005] = "Bad component type"
  
  class ComponentDescription < FFI::Struct
    layout :componentType,         :uint32,
           :componentSubType,      :uint32,
           :componentManufacturer, :uint32,
           :componentFlags,        :ulong,
           :componentFlagsMask,    :ulong
  end
  
  module ::Kernel
    def ComponentDescription(opts)
      case opts
      when ComponentDescription then opts
      else
        desc = ComponentDescription.new
        desc[:componentType]         = OSType(opts[:type])
        desc[:componentSubType]      = OSType(opts[:subtype])
        desc[:componentManufacturer] = OSType(opts[:manufacturer])
        desc[:componentFlags]        = opts.fetch(:flags, 0)
        desc[:componentFlagsMask]    = opts.fetch(:flags_mask, 0)
        desc
      end
    end
  end
end
