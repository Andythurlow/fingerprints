
module Chunky
  class ChunkyPNG::Image
    def at(x,y)
      ChunkyPNG::Color.to_grayscale_bytes(self[x,y]).first
    end
  end
end
