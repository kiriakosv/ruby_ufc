# frozen_string_literal: true

module RubyUfc
  # :nodoc:
  class Client
    attr_reader :base_end_point, :version

    def initialize
      config_params = YAML.load_file('lib/config/config.yml')
      @base_end_point = config_params['base_end_point']
      @version = config_params['version']
    end
  end
end
