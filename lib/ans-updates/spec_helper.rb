# -*- coding: utf-8 -*-

module Ans::Updates
  module SpecHelper

    def self.for_view_spec

      module Helper
        # view のテストでルーティングエラーになる問題を回避
        def updates_get_link(label,opts={})
          nil
        end
      end

    end

  end
end
