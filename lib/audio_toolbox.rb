module AudioToolbox
  extend FFI::Library
  ffi_lib '/System/Library/Frameworks/AudioToolbox.framework/Versions/Current/AudioToolbox'
end

require 'audio_toolbox/augraph'
