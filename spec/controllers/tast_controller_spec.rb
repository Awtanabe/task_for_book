require'rails_helper'

RSpec.describe TasksController, type: :controller do 

  before do
    @user = create(:user)
    login(@user)         
  end 
  describe "index" do 
    
    it "success" do 
      get :index

      expect(response).to be_success
    end
  end

  
  describe "show" do 
    it "success" do 
      task = create(:task, user: @user)
       
      get :show, params: {id: task.id} 
      expect(response).to render_template :show  
    end
  end

  describe "create" do 
    it "success" do
      post :create, params: {
        task: 
          {
            name: "test", 
            description:"test",
            user_id: @user.id
          }
      }
      
      expect(response).to have_http_status "302"
    end
  end

  describe "update" do 
    it "success" do 
       @task = Task.create(name:"task1", description:"test1", user: @user)

       params = {
            name: "upda", 
            description:"test"
          }
       patch :update, params: { id: @task.id, task: params}
       expect(@task.reload.name).to eq "upda"
    end
  end


  describe "delete" do
   it "success" do 
    @task = Task.create(name:"task1", description:"test1", user: @user)

    delete :destroy, params: {id: @task.id}
    expect(Task.count).to eq 0
   end
  end
end