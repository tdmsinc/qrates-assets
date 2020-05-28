require 'qrates/assets/version'

module Qrates
  module Assets
    def self.gem_path
      Pathname.new(File.dirname(__dir__))
    end

    def self.gem_spec
      Gem::Specification::load(
        gem_path.join('qrates-assets.gemspec').to_s
      )
    end

    def self.load_paths
      gem_path.join('../vendor/assets').each_child.to_a
    end

    def self.dependencies
      []
    end

    if defined?(::Rails)
      class Engine < ::Rails::Engine
      end
    end
  end
end

class RailsAssets
  @components ||= []

  class << self
    attr_accessor :components

    def load_paths
      components.flat_map(&:load_paths)
    end
  end
end

RailsAssets.components << Qrates::Assets
