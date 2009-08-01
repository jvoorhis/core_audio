module AudioUnit
  extend FFI::Library
  ffi_lib '/System/Library/Frameworks/AudioUnit.framework/Versions/Current/AudioUnit'
  
  attach_function :MusicDeviceMIDIEvent, [:pointer, :int, :int, :int, :int], :long
  
  class AudioUnit < FFI::Struct
    layout :data, [:long, 1]
  end
  
  module MusicDevice
    include ::MIDIDestination
    
    def send_bytes(*args)
      arg0 = args[0] || 0
      arg1 = args[1] || 0
      arg2 = args[2] || 0
      require_noerr("MusicDeviceMIDIEvent") {
        ::AudioUnit.MusicDeviceMIDIEvent(self.pointer, arg0, arg1, arg2, 0)
      }
    end
  end
end
