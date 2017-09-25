require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
module Highlight
  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end
end