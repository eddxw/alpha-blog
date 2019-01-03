# frozen_string_literal: true

require 'test_helper'
class SigningUpTest < ActionDispatch::IntegrationTest
  test 'sign up user' do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: 'eduardo',
                                          email: 'eduardo@sample.com', password: '1234' } }
      follow_redirect!
    end
    assert_template 'users/show'
    assert_select 'h4'
    assert_match "eduardo's articles", response.body
  end

  test 'invalid sign up' do
    get signup_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: 'ed',
                                          email: 'edsample.com', password: '123' } }
    end
    assert_template 'users/new'
    #assert flash errors
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
