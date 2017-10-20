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
      define_method(allowed_resource) do |args = {}|
        url = construct_url(allowed_resource)
        response = get_json_response(url)
        return response if args.empty?
        filter_by_argument(response, args)
      end

      define_method(allowed_resource + '_attributes') do
        response = send(allowed_resource.to_sym)
        response.first.keys.map(&:to_sym).sort
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

    def filter_by_argument(response, args)
      key = args.keys.first
      value = args[key]
      response.select { |ans| ans[key.to_s] == value }
    end
  end
end
