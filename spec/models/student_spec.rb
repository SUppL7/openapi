require 'rails_helper'

Rspec.describe Student, type: :model do
  it "valid student" do
    student = create(:student)
    expect(student).to be_valid
  end
end
