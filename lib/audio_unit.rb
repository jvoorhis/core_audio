module AudioUnit
  extend FFI::Library
  ffi_lib '/System/Library/Frameworks/AudioUnit.framework/Versions/Current/AudioUnit'
  
  attach_function :MusicDeviceMIDIEvent, [:pointer, :int, :int, :int, :int], :long
  
  MAC_ERRORS[-10879] = "Invalid property"
	MAC_ERRORS[-10878] = "Invalid parameter"
	MAC_ERRORS[-10877] = "Invalid element"
	MAC_ERRORS[-10876] = "No connection"
	MAC_ERRORS[-10875] = "Failed initialization"
	MAC_ERRORS[-10874] = "Too many frames to process"
	MAC_ERRORS[-10873] = "Illegal instrument"
	MAC_ERRORS[-10872] = "Instrument type not found"
	MAC_ERRORS[-10871] = "Invalid file"
	MAC_ERRORS[-10870] = "UnknownFileType"
	MAC_ERRORS[-10869] = "File not specified"
	MAC_ERRORS[-10868] = "Format not supported"
	MAC_ERRORS[-10867] = "Uninitialized"
	MAC_ERRORS[-10866] = "Invalid scope"
	MAC_ERRORS[-10865] = "Property not writable"
	MAC_ERRORS[-10851] = "Invalid property value"
	MAC_ERRORS[-10850] = "Property not in use"
	MAC_ERRORS[-10849] = "Initialized"
	MAC_ERRORS[-10848] = "Invalid offline render"
	MAC_ERRORS[-10847] = "Unauthorized"
  
  class AudioUnit < FFI::Struct
    layout :data, [:long, 1]
    
    def initialize(component_description, *args)
      super(*args)
      extend_with_component_description(component_description)
    end
    
    private
    
    def extend_with_component_description(component_description)
      if component_description[:componentType] == OSType('aumu')
        extend(MusicDevice)
      end
    end
  end
  
  module MusicDevice
    include ::MIDIDestination
    
    def send_midi_bytes(*args)
      arg0 = args[0] || 0
      arg1 = args[1] || 0
      arg2 = args[2] || 0
      require_noerr("MusicDeviceMIDIEvent") {
        ::AudioUnit.MusicDeviceMIDIEvent(self.pointer, arg0, arg1, arg2, 0)
      }
    end
  end
end
