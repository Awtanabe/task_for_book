require'rails_helper'

RSpec.describe TasksController, type: :controller do 

  describe "index" do 
    it "success" do 
      get :index

      expect(response).to be_success
    end
  end

  describe "create" do 
    it "success" do
      post :create, params: {
        task: 
          {
            name: "test", 
            description:"test"
          }
      }
      
      expect(response).to have_http_status "302"
    end
  end

  describe "update" do 
    it "success" do 
       @task = Task.create(name:"task1", description:"test1")
       params = {
            name: "updated", 
            description:"test"
          }
       patch :update, params: { id: @task.id, task: params}
       expect(@task.reload.name).to eq "updated"
    end
  end


  describe "delete" do
   it "success" do 
    @task = Task.create(name:"task1", description:"test1")

    delete :destroy, params: {id: @task.id}
    expect(Task.count).to eq 0
   end
  end
end