require "ans-updates/version"

module Ans
  module Updates
    include ActiveSupport::Configurable

    configure do |config|
      config.path                   = "updates"
      config.changelog_pattern      = "changelogs/*"
      config.changelog_suffix       = ".md"
      config.changelog_date_pattern = /(\d+-\d+-\d+)/

      config.limit         = 20
      config.date_format   = "%Y/%m/%d"
      config.template_name = "ans-updates/show_update"
    end

    class Engine < Rails::Engine
    end

    autoload :Helper,       "ans-updates/helper.rb"
    autoload :CommonHelper, "ans-updates/common_helper.rb"

    def self.included(m)
      m.send :include, CommonHelper
      m.send :before_filter, :updates_get
    end

    def updates_get
      return unless params[:get_updates]

      `#{[
        %{cd #{updates_path}},
        %{git checkout master},
        %{git pull},
      ].join(" && ")}`
    end
  end
end
