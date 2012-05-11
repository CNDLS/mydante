module Sass
  module Rails
    module Helpers
      protected
      def public_path(asset, kind)
        resolver = options[:custom][:resolver]
        asset_paths = resolver.context.asset_paths
        path = resolver.public_path(asset, kind.pluralize)
        if !asset_paths.send(:has_request?) && ENV['RAILS_RELATIVE_URL_ROOT']
          path = ENV['RAILS_RELATIVE_URL_ROOT'] + path
        end
        path
      end
    end
  end
end