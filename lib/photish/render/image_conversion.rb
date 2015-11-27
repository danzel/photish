require 'mini_magick'

module Photish
  module Render
    class ImageConversion
      def initialize(output_dir)
        @output_dir = output_dir
        @log = Logging.logger[self]
      end

      def render(images)
        Array(images).each do |image|
          output_file = File.join(output_dir, image.url_parts)
          FileUtils.mkdir_p(File.join(output_dir, image.base_url_parts))

          MiniMagick::Tool::Convert.new do |convert|
            convert << image.path
            convert.merge!(image.quality_params)
            convert << output_file
            log.info "Performing image conversion #{convert.command}"
          end
        end
      end

      private

      attr_reader :output_dir,
                  :log
    end
  end
end
