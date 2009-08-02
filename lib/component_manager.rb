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
    def ComponentDescription(*args)
      case args[0]
      when ComponentDescription then return args[0]
      when Hash
        opts = args.first
        componentType         = OSType(opts[:type])
        componentSubType      = OSType(opts[:subtype])
        componentManufacturer = OSType(opts[:manufacturer])
        componentFlags        = opts.fetch(:flags, 0)
        componentFlagsMask    = opts.fetch(:flags_mask, 0)
      when String, Symbol
        componentType         = OSType(args[0])
        componentSubType      = OSType(args[1])
        componentManufacturer = OSType(args[2])
        componentFlags        = 0
        componentFlagsMask    = 0
      else
        raise ArgumentError, "Cannot construct a ComponentDescription from #{args}"
      end
      
      desc = ComponentDescription.new
      desc[:componentType]         = componentType
      desc[:componentSubType]      = componentSubType
      desc[:componentManufacturer] = componentManufacturer
      desc[:componentFlags]        = componentFlags
      desc[:componentFlagsMask]    = componentFlagsMask
      desc
    end
  end
end
