require'rails_helper'

RSpec.describe  Task, type: :model do 
  describe "task" do 
    it "it is valid with name and decription" do
      task = Task.new(name:"test", description:"test task") 
      expect(task).to be_valid
    end

    it "it is invalid when name is blank " do
      task = Task.new(name:"", description:"test task") 
      expect(task).not_to be_valid
    end
  end
end