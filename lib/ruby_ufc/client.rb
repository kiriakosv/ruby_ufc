# frozen_string_literal: true

module RubyUfc
  # :nodoc:
  class Client
    ALLOWED_RESOURCES = %w[fighters octagon_girls events news media].freeze

    attr_reader :base_end_point, :version

    def initialize
      config_params = YAML.load_file('lib/config/config.yml')
      @base_end_point = config_params['base_end_point']
      @version = config_params['version']
    end

    ALLOWED_RESOURCES.each do |allowed_resource|
      define_method(allowed_resource) do
        url = construct_url(allowed_resource)
        get_json_response(url)
      end
    end

    private

    def construct_url(name)
      "#{@base_end_point}/#{@version}/#{name}.json"
    end

    def get_json_response(url)
      uri = URI(url)
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end
  end
end
