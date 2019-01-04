# frozen_string_literal: true

require 'test_helper'
class CreateArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'john', email: 'john@example.com',
                        password: 'password', admin: true)
  end

  test 'get new article form and create article' do
    sign_in_as(@user, 'password')
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, params: {article: {title: 'Mexican Sushi', description: 'Mexican sushi is the best'}}
      follow_redirect!
    end
    assert_template 'articles/show'
    # assert created by @user
    assert_select 'li.article-title a'
    assert_match @user.username, response.body
  end
  test 'should render articles/new when failing to create article' do
    sign_in_as(@user, 'password')
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, params: {article: {title: 'Me', description: 'Mexican sushi is the best'}}
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
