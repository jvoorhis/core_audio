module CoreAudio
  class AudioStreamBasicDescription < FFI::Struct
    layout :sample_rate, :double,
           :format_id, :uint32,
           :format_flags, :uint32,
           :bytes_per_packet, :uint32,
           :frames_per_packet, :uint32,
           :bytes_per_frame, :uint32,
           :bits_per_channel, :uint32,
           :reserved, :uint32
  end
end
