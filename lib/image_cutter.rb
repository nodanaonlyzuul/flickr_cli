module FlickrCli
  module ImageCutter

    CHARS = [ 'W', 'M', '$', '@', '#', '%', '^', 'x', '*', 'o', '=', '+',':', '~', '.', ' ' ]
    FONT_ROWS = 8
    FONT_COLS = 4

    def self.convert_to_ascii(file)

      img = Magick::Image.read(file).first

      # Resize too-large images. The resulting image is going to be
      # about twice the size of the input, so if the original image is too
      # large we need to make it smaller so the ASCII version won't be too
      # big. The `change_geometry' method computes new dimensions for an
      # image based on the geometry argument. The '320x320>' argument says
      # "If the image is too big to fit in a 320x320 square, compute the
      # dimensions of an image that will fit, but retain the original aspect
      # ratio. If the image is already smaller than 320x320, keep the same
      # dimensions."
      img.change_geometry('728x728>') do |cols, rows|
        img.resize!(cols, rows) if cols != img.columns || rows != img.rows
      end

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