# frozen_string_literal: true

require 'test_helper'

class ClientTest < Minitest::Test
  def test_that_it_initializes_properly
    client = RubyUfc::Client.new
    assert_equal client.base_end_point, 'http://ufc-data-api.ufc.com/api'
    assert_equal client.version, 'v3'
  end

  def test_that_all_allowed_methods_exist
    client = RubyUfc::Client.new
    RubyUfc::Client::ALLOWED_RESOURCES.each do |allowed_resource|
      assert client.respond_to? allowed_resource
    end
  end

  def test_that_an_allowed_method_returns_correct_values
    client = RubyUfc::Client.new
    method = RubyUfc::Client::ALLOWED_RESOURCES.first

    response = client.send(method)
    assert response.class, Array
  end

  def test_that_construct_url_returns_a_correct_url
    client = RubyUfc::Client.new
    base_end_point = client.base_end_point
    version = client.version
    resource = RubyUfc::Client::ALLOWED_RESOURCES.first

    url = client.send(:construct_url, resource)
    assert_equal url, "#{base_end_point}/#{version}/#{resource}.json"
  end
end
