module Kernel
  def require_noerr(*args)
    osstatus = yield
    if osstatus != 0
      message = ""
      message << args.shift if args.first.kind_of?(String)
      table = args.first.kind_of?(Hash) ? args.shift : {}
      if error = table[osstatus]
        message << ": " << error
      end
      raise RuntimeError, message
    end
  end
end
