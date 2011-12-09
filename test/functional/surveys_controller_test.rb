require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  setup do
    @survey = surveys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:surveys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create survey" do
    assert_difference('Survey.count') do
      post :create, survey: @survey.attributes
    end

    assert_redirected_to survey_path(assigns(:survey))
  end

  test "should show survey" do
    get :show, id: @survey.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @survey.to_param
    assert_response :success
  end

  test "should update survey" do
    put :update, id: @survey.to_param, survey: @survey.attributes
    assert_redirected_to survey_path(assigns(:survey))
  end

  test "should destroy survey" do
    assert_difference('Survey.count', -1) do
      delete :destroy, id: @survey.to_param
    end

    assert_redirected_to surveys_path
  end
end
