# frozen_string_literal: true

require 'test_helper'

class ClientTest < Minitest::Test
  def test_that_it_initializes_properly
    client = RubyUfc::Client.new
    assert_equal client.base_end_point, 'http://ufc-data-api.ufc.com/api/'
    assert_equal client.version, 'v3'
  end
end
