module FlickrCli
  module ImageCutter

    CHARS = [ 'W', 'M', '$', '@', '#', '%', '^', 'x', '*', 'o', '=', '+',':', '~', '.', ' ' ]
    FONT_ROWS = 8
    FONT_COLS = 4

    def self.convert_to_ascii(file)

      img = Magick::Image.read(file).first
      img.resize_to_fit!('728')

      # Compute the image size in ASCII "pixels" and resize the image to have
      # those dimensions. The resulting image does not have the same aspect
      # ratio as the original, but since our "pixels" are twice as tall as
      # they are wide we'll get our proportions back (roughly) when we render.
      pr = img.rows / FONT_ROWS
      pc = img.columns / FONT_COLS
      img.resize!(pc, pr)

      img = img.quantize(16, Magick::GRAYColorspace)
      img = img.normalize

      # Draw the image surrounded by a border. The `view' method is slow but
      # it makes it easy to address individual pixels. In grayscale images,
      # all three RGB channels have the same value so the red channel is as
      # good as any for choosing which character to represent the intensity of
      # this particular pixel.
      border = '+' + ('-' * pc) + '+'
      puts border

      img.view(0, 0, pc, pr) do |view|
        pr.times do |i|
        putc '|'
        pc.times { |j| putc CHARS[view[i][j].red/16] }
        puts '|'
      end

      end
      border
    end
  end
end