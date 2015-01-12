require 'rails_helper'

RSpec.describe CoursesController, :type => :controller do

  let!(:course) { create(:course) }
  let(:user) { create(:user) }

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

  pending "as a user" do

    before(:each) { session[:user_id] = create(:user).id }

    pending "index - assigns @courses & renders index" do
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
