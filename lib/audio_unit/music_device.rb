module AudioUnit
  attach_function :MusicDeviceMIDIEvent, [:pointer, :int, :int, :int, :int], :long
  
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
