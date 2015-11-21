require 'photish/gallery/traits/urlable'
require 'photish/gallery/image'
require 'active_support'
require 'active_support/core_ext'

module Photish
  module Gallery
    class Photo

      include ::Photish::Gallery::Traits::Urlable

      delegate :qualities, to: :parent, allow_nil: true

      def initialize(parent, path)
        @parent = parent
        @path = path
      end

      def name
        @name ||= File.basename(path, '.*')
      end

      def images
        qualities.map { |quality| Photish::Gallery::Image.new(self, path, quality) }
      end

      private

      attr_reader :path,
                  :parent

      alias_method :base_url_name, :name

      def url_end
        'index.html'
      end
    end
  end
end
