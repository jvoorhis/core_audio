class String
  def to_ostype
    bytes = 0
    self.each_byte do |byte|
      bytes <<= 8
      bytes += byte
    end
    return bytes
  end
end
