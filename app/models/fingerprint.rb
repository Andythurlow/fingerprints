# -*- encoding : utf-8 -*-

class Fingerprint
  # < ActiveRecord::Base
  include Chunky
  attr_reader :img_src, :img

  def initialize(img_src)
    @img_src = img_src
    @img = ChunkyPNG::Image.from_file(Rails.root.join('app', 'assets', 'images').to_s + "/#{img_src}")
  end

  def find_edges(value=15)
    new_image = ChunkyPNG::Image.new(@img.width, @img.height, ChunkyPNG::Color::TRANSPARENT)

    for x in 1..@img.width-2
      for y in 1..@img.height-2
        pixel_x = (sobel_x[0][0] * @img.at(x-1,y-1)) + (sobel_x[0][1] * @img.at(x,y-1)) + (sobel_x[0][2] * @img.at(x+1,y-1)) +
                  (sobel_x[1][0] * @img.at(x-1,y))   + (sobel_x[1][1] * @img.at(x,y))   + (sobel_x[1][2] * @img.at(x+1,y)) +
                  (sobel_x[2][0] * @img.at(x-1,y+1)) + (sobel_x[2][1] * @img.at(x,y+1)) + (sobel_x[2][2] * @img.at(x+1,y+1))

        pixel_y = (sobel_y[0][0] * @img.at(x-1,y-1)) + (sobel_y[0][1] * @img.at(x,y-1)) + (sobel_y[0][2] * @img.at(x+1,y-1)) +
                  (sobel_y[1][0] * @img.at(x-1,y))   + (sobel_y[1][1] * @img.at(x,y))   + (sobel_y[1][2] * @img.at(x+1,y)) +
                  (sobel_y[2][0] * @img.at(x-1,y+1)) + (sobel_y[2][1] * @img.at(x,y+1)) + (sobel_y[2][2] * @img.at(x+1,y+1))

        val = Math.sqrt((pixel_x * pixel_x) + (pixel_y * pixel_y)).ceil
        if val < value
          new_image[x,y] = ChunkyPNG::Color.rgb(255,255,255)
        else
          new_image[x,y] = ChunkyPNG::Color.rgb(0,0,0)
        end
      end
    end

    new_filename = "#{@img_src.split(".").first+ '_' + Time.current.iso8601}.png"
    new_image.save(new_filename)


    FileUtils.mv(Rails.root.to_s + "/#{new_filename}", Rails.root.join("app","assets","images","converts"))
  end

  private

  def sobel_x
    [
     [-1,0,1],
     [-2,0,2],
     [-1,0,1]
    ]
  end

  def sobel_y
    [
     [-1,-2,-1],
     [0,0,0],
     [1,2,1]
    ]
  end

end


# require 'fileutils'

