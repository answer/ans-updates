require "redcarpet"

module Ans::Updates
  module Helper
    include CommonHelper

    def updates_show
      Dir[updates_changelog_pattern].sort.reverse[0..(config.limit-1)].map do |path|
        render(
          config.template_name,
          id:      updates_changelog_id(path),
          date:    updates_changelog_date(path),
          content: File.read(path),
        )
      end.join("").html_safe
    end

    def updates_changelog_pattern
      File.join updates_path, "#{config.changelog_pattern}#{config.changelog_suffix}"
    end
    def updates_changelog_id(path)
      File.basename path, config.changelog_suffix
    end
    def updates_changelog_date(path)
      if File.basename(path) =~ config.changelog_date_pattern
        Date.parse $1
      end
    rescue ArgumentError
    end

    def updates_date(date)
      date.strftime config.date_format
    end
    def updates_content(content)
      md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
      md.render(content).html_safe
    end

    def updates_get_link(label,opts={})
      link_to label, {controller: controller_path, action: action_name, get_updates: true}, opts
    end
  end
end
