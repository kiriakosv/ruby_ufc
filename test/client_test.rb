# frozen_string_literal: true

require 'test_helper'

class ClientTest < Minitest::Test
  def setup
    @client = RubyUfc::Client.new
  end

  def test_that_it_initializes_properly
    assert_equal @client.base_end_point, 'http://ufc-data-api.ufc.com/api'
    assert_equal @client.version, 'v3'
  end

  def test_that_all_allowed_methods_exist
    RubyUfc::Client::ALLOWED_RESOURCES.each do |allowed_resource|
      assert @client.respond_to? allowed_resource
    end
  end

  def test_that_allowed_method_returns_correct_values_without_optional_args
    method = RubyUfc::Client::ALLOWED_RESOURCES.first

    response = @client.send(method)
    assert response.class, Array
  end

  def test_that_allowed_method_returns_correct_values_with_existing_arg_value
    method = RubyUfc::Client::ALLOWED_RESOURCES.first

    response = @client.send(method, first_name: 'Conor')
    response.each do |resource|
      assert resource.key? :first_name.to_s
      assert_equal resource[:first_name.to_s], 'Conor'
    end
  end

  def test_that_allowed_method_returns_empty_array_when_filter_unsatisfied
    method = RubyUfc::Client::ALLOWED_RESOURCES.first

    response = @client.send(method, first_name: 'kldfjaklds')
    assert response.empty?
  end

  def test_that_construct_url_returns_a_correct_url
    base_end_point = @client.base_end_point
    version = @client.version
    resource = RubyUfc::Client::ALLOWED_RESOURCES.first

    url = @client.send(:construct_url, resource)
    assert_equal url, "#{base_end_point}/#{version}/#{resource}.json"
  end

  def test_that_filter_for_argument_returns_correct_values
    response = [
      { 'first_name' => 'Nick' },
      { 'first_name' => 'Helen' }
    ]
    args = { first_name: 'Nick' }

    returned = @client.send(:filter_by_argument, response, args)
    returned.each do |resource|
      assert resource.key? :first_name.to_s
      assert_equal resource[:first_name.to_s], 'Nick'
    end
  end

  def test_that_attributes_method_returns_correct_value
    method = RubyUfc::Client::ALLOWED_RESOURCES.first
    method += '_attributes'
    attributes = @client.send(method)
    assert_equal attributes.class, Array
    attributes.each { |attribute| assert_equal attribute.class, Symbol }
  end
end
