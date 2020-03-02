require 'test_helper'

class WidgetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get widgets_path
    assert_response :success
  end

  test "should get all widgets on landing  page" do
    get widgets_path
    assert_response :success
    assert_not_nil assigns[:widgets]
  end

  test "should return all widgets that matches criteria when user do a search on landing  page" do
    get widgets_path(term: 'ajax')
    assert_response :success
    assert_not_nil assigns[:widgets]
    assert_not_empty assigns[:widgets]
  end

  test "should search only in all widgets if user  is not logged in" do
    get widgets_path(term: 'ajax', id: 1)
    assert_response :success
    assert_not_nil assigns[:widgets]
    assert_not_empty assigns[:widgets]
  end

  test "should be able to view the segregated widgets only if logged " do
    log_me_in_as('as@yopmail.com', 'password')
    get my_widgets_path(term: 'ajax', id: 'me')
    assert_response :success
    assert_not_nil assigns[:widgets]
  end

  test "CREATE#should be able to create the widget after login" do
    log_me_in_as('as@yopmail.com', 'password')
    get my_widgets_path(id: 'me')
    assert_response :success
    assert_not_nil assigns[:widgets]
    post widgets_path(name: widget_name, description:  'test  description', kind: 'visible')

    get my_widgets_path(id: 'me', term: widget_name)
    assert_response :success
    assert_not_nil assigns[:widgets]
    assert_not_empty assigns[:widgets]
    assert_equal assigns[:widgets].first['name'], widget_name
  end

  private
  def create_widget_name
    "test widget #{rand(1000000)}"
  end

  def widget_name
    @widget_name ||= create_widget_name
  end
end
