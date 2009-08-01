MAC_ERRORS = {}

module Kernel
  def require_noerr(error_string = nil)
    osstatus = yield
    if osstatus != 0
      message = "[#{osstatus}]"
      if error_string
        message << " " << error_string
      end
      if error = MAC_ERRORS[osstatus]
        message << ": " << error
      end
      raise RuntimeError, message
    end
  end
  
  def OSType(arg)
    case arg
    when String
      arg.ljust(4)[0..3].to_bytes
    when Integer
      arg
    else
      raise RuntimeError, "Cannot coerce #{arg} to OSType"
    end
  end
end
