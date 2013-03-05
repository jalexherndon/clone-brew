require 'spec_helper'

describe MashStep do
  it "should not allow step_types outside of MashStep::STEP_TYPES" do
    expect {
      MashStepBuilder.basic_mash_step
                     .with_step_type(MashStep::STEP_TYPES.length)
                     .build
                     .save!
      }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should allow all step_types within MashStep::STEP_TYPES" do
    for step_type in MashStep::STEP_TYPES
      MashStepBuilder.basic_mash_step
                     .with_step_type(step_type)
                     .build
                     .save!
    end
  end
end
