module Photish
  module Config
    class DefaultConfig
      def hash
        {
          port: 9876,
          site_dir: File.join(Dir.pwd, 'site'),
          photo_dir: File.join(Dir.pwd, 'photos'),
          output_dir: File.join(Dir.pwd, 'output'),
          max_workers: Facter.value('processors')['count'],
          qualities: [
            { name: 'Original',
              params: [] },
            { name: 'Low',
              params: ['-resize', '200x200'] }
          ],
          templates: {
            layout: 'layout.slim',
            collection: 'collection.slim',
            album: 'album.slim',
            photo: 'photo.slim'
          },
          logging: {
            colorize: true,
            output: ['stdout', 'file'],
            level: 'info'
          },
          url: {
            host: '/',
            base: nil
          }
        }
      end
    end
  end
end
