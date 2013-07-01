# -*- coding: utf-8 -*-

module Ans::Updates
  module SpecHelper

    def self.for_view_spec

      # view のテストでルーティングエラーになる問題を回避
      Helper.send :define_method, :updates_get_link do |label,opts={}|
      end

    end

  end
end
