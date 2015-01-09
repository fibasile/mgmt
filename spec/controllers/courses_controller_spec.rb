require 'rails_helper'

RSpec.describe CoursesController, :type => :controller do

  let!(:course) { FactoryGirl.create(:course) }
  let(:user) { FactoryGirl.create(:user) }

  pending "as a guest" do

    it "index - assigns @courses & renders index" do
      get :index
      expect(assigns(:courses)).to eq([course])
      expect(response).to render_template("index")
    end

    it "show - assigns @course & renders show" do
      get :show, id: course.id
      expect(assigns(:course)).to eq(course)
      expect(response).to render_template("show")
    end

  end

  context "as a user" do

    before(:each) { sign_in(user) }

    it "index - assigns @courses & renders index" do
      get :index
      expect(assigns(:courses)).to eq([course])
      expect(response).to render_template("index")
    end

    pending "edit - assigns @course & renders edit" do
      get :edit, id: course.id
      expect(assigns(:course)).to eq(course)
      expect(response).to render_template("edit")
    end

    pending "update - assigns @course & redirects to show" do
      patch :update, id: course.id, course: course.attributes
      expect(assigns(:course)).to eq(course)
      expect(response).to redirect_to(course)
    end

  end

  pending "as an admin"

end
