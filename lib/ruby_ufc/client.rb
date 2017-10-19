# frozen_string_literal: true

module RubyUfc
  # :nodoc:
  class Client
    attr_reader :base_end_point, :version

    def initialize
      config = YAML.load_file('lib/config/config.yml')
      @base_end_point = config['base_end_point']
      @version = config['version']
    end
  end
end
