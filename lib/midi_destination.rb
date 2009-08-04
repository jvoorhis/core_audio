# MIDIDestination mixin provides an interface to common MIDI messages for
# any class implementing #send_midi_bytes(*bytes)
module MIDIDestination
  ON  = 0x90 # Note on
  OFF = 0x80 # Note off
  PA  = 0xa0 # Polyphonic aftertouch
  CC  = 0xb0 # Control change
  PC  = 0xc0 # Program change
  CA  = 0xd0 # Channel aftertouch
  PB  = 0xe0 # Pitch bend
  
  def note_on(channel, note, velocity)
    send_midi_bytes(ON | channel, note, velocity)
  end
  
  def note_off(channel, note, velocity = 0)
    send_midi_bytes(OFF | channel, note, velocity)
  end
  
  def aftertouch(channel, note, pressure)
    send_midi_bytes(PA | channel, note, pressure)
  end
  
  def control_change(channel, number, value)
    send_midi_bytes(CC | channel, number, value)
  end
  
  def program_change(channel, program)
    send_midi_bytes(PC | channel, program)
  end
  
  def channel_aftertouch(channel, pressure)
    send_midi_bytes(CA | channel, pressure)
  end
  
  def pitch_bend(channel, value)
    send_midi_bytes(PB | channel, value)
  end  
end
