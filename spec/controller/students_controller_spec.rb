require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  include Devise::Test::ControllerHelpers

  # Add this line to create a user for your tests
  let(:user) { create(:user) }

  before do
    sign_in user  # Sign in the user before each test
  end
  let(:valid_attributes) {
    { name: "John Doe", subject_name: "Math", marks: 80 }
  }

  let(:invalid_attributes) {
    { name: "", subject_name: "Math", marks: nil }
  }

  describe "GET #index" do
    it "returns a success response" do
      Student.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "when a student does not exist" do
      it "creates a new Student" do
        expect {
          post :create, params: { student: valid_attributes }
        }.to change(Student, :count).by(1)
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Student was successfully created.')
      end
    end

    context "when a student already exists" do
      it "updates the existing student's marks" do
        Student.create! valid_attributes
        new_marks = { name: "John Doe", subject_name: "Math", marks: 30 }
        
        post :create, params: { student: new_marks }
        
        student = Student.find_by(name: "John Doe", subject_name: "Math")
        expect(student.marks).to eq(110) # 80 + 30
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Student marks were successfully updated.')
      end
    end

    context "with invalid parameters" do
      it "does not create a student and re-renders the form" do
        expect {
          post :create, params: { student: invalid_attributes }
        }.to change(Student, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      student = Student.create! valid_attributes
      get :edit, params: { id: student.to_param }
      expect(response).to be_successful
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid parameters" do
      it "updates the requested student" do
        student = Student.create! valid_attributes
        new_attributes = { marks: 90 }
        
        patch :update, params: { id: student.to_param, student: new_attributes }
        student.reload
        expect(student.marks).to eq(90)
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Student was successfully updated.')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested student" do
      student = Student.create! valid_attributes
      expect {
        delete :destroy, params: { id: student.to_param }
      }.to change(Student, :count).by(-1)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Student was successfully deleted.')
    end
  end
end
