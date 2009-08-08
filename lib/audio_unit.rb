require 'audio_unit/music_device'

module AudioUnit
  extend FFI::Library
  ffi_lib '/System/Library/Frameworks/AudioUnit.framework/Versions/Current/AudioUnit'
  
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
  
  # Lookup table for AudioUnit type-specific extension modules
  TYPE_EXTENSIONS = {
    OSType('aumu') => MusicDevice
  }
  
  class AudioUnit < FFI::Struct
    layout :data, [:long, 1]
    
    def initialize(component_description, *args)
      super(*args)
      extend_with_component_description(component_description)
    end
    
    def get_property(property_id, scope, element, type)
      type_size = FFI.size_of(type)
      data = FFI::MemoryPointer.new(type_size)
      size = FFI::MemoryPointer.new(:uint32)
      size.write_int(type_size)
      require_noerr("AudioUnitGetProperty") {
        ::AudioUnit.AudioUnitGetProperty(self, property_id, scope, element, data, size)
      }
      data.as_type(type)
    end
    
    # Global properties
    
    def stream_format
      get_property(8, 0, 0, CoreAudio::AudioStreamBasicDescription)
    end
    
    private
    
    def extend_with_component_description(component_description)
      Array(TYPE_EXTENSIONS[OSType('aumu')]).each(&method(:extend))
    end
  end
  
  attach_function :AudioUnitGetProperty, [:pointer, :uint32, :uint32, :uint32, :pointer, :pointer], :int
  attach_function :AudioUnitSetProperty, [:pointer, :uint32, :uint32, :uint32, :pointer, :uint32], :int
  attach_function :MusicDeviceMIDIEvent, [AudioUnit, :int, :int, :int, :int], :long
end
