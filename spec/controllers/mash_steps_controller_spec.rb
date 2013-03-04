require 'spec_helper'

describe MashStepsController do
  login_user

  before(:each) do
    @mash_step = MashStepBuilder.basic_mash_step.build
    @mash_step.save!
  end

  it "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mash_steps)
  end

  it "should create mash_step" do
    assert_difference('MashStep.count') do
      response = post :create, mash_step: {
        description: @mash_step.description,
        mash_volume: @mash_step.mash_volume,
        recipe_id: @mash_step.recipe_id,
        step_type: @mash_step.step_type,
        temperature: @mash_step.temperature,
        time: @mash_step.time
      }
    end

    assert_response_equals_mash_step response, @mash_step
  end

  it "should show mash_step" do
    response = get :show, id: @mash_step
    assert_response_equals_mash_step response, @mash_step
  end

  it "should update mash_step" do
    response = put :update, id: @mash_step, mash_step: {
      description: @mash_step.description,
      mash_volume: @mash_step.mash_volume,
      recipe_id: @mash_step.recipe_id,
      step_type: @mash_step.step_type,
      temperature: @mash_step.temperature,
      time: @mash_step.time
    }

    assert_response_equals_mash_step response, @mash_step
  end

  it "should destroy mash_step" do
    assert_difference('MashStep.count', -1) do
      delete :destroy, id: @mash_step
    end

    assert_response :no_content
  end

  def assert_response_equals_mash_step(response, mash_step)
    json_step = JSON.parse(response.body)
    assert_not_nil json_step

    assert_equal mash_step.description, json_step['description']
    assert_equal mash_step.mash_volume, json_step['mash_volume']
    assert_equal mash_step.recipe_id, json_step['recipe_id']
    assert_equal mash_step.step_type, json_step['step_type']
    assert_equal mash_step.temperature, json_step['temperature']
    assert_equal mash_step.time, json_step['time']
  end
end
