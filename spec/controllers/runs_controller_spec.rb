require 'rails_helper'

RSpec.describe RunsController, type: :controller do
  skip 'no valid runs controller tests yet :(' do
    # This should return the minimal set of attributes required to create a valid
    # Run. As you add validations to Run, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) {
      skip("Add a hash of attributes valid for your model")
    }

    let(:invalid_attributes) {
      skip("Add a hash of attributes invalid for your model")
    }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # RunsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET #index" do
      it "assigns all runs as @runs" do
        run = Run.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(assigns(:runs)).to eq([run])
      end
    end

    describe "GET #show" do
      it "assigns the requested run as @run" do
        run = Run.create! valid_attributes
        get :show, params: {id: run.to_param}, session: valid_session
        expect(assigns(:run)).to eq(run)
      end
    end

    describe "GET #new" do
      it "assigns a new run as @run" do
        get :new, params: {}, session: valid_session
        expect(assigns(:run)).to be_a_new(Run)
      end
    end

    describe "GET #edit" do
      it "assigns the requested run as @run" do
        run = Run.create! valid_attributes
        get :edit, params: {id: run.to_param}, session: valid_session
        expect(assigns(:run)).to eq(run)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Run" do
          expect {
            post :create, params: {run: valid_attributes}, session: valid_session
          }.to change(Run, :count).by(1)
        end

        it "assigns a newly created run as @run" do
          post :create, params: {run: valid_attributes}, session: valid_session
          expect(assigns(:run)).to be_a(Run)
          expect(assigns(:run)).to be_persisted
        end

        it "redirects to the created run" do
          post :create, params: {run: valid_attributes}, session: valid_session
          expect(response).to redirect_to(Run.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved run as @run" do
          post :create, params: {run: invalid_attributes}, session: valid_session
          expect(assigns(:run)).to be_a_new(Run)
        end

        it "re-renders the 'new' template" do
          post :create, params: {run: invalid_attributes}, session: valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          skip("Add a hash of attributes valid for your model")
        }

        it "updates the requested run" do
          run = Run.create! valid_attributes
          put :update, params: {id: run.to_param, run: new_attributes}, session: valid_session
          run.reload
          skip("Add assertions for updated state")
        end

        it "assigns the requested run as @run" do
          run = Run.create! valid_attributes
          put :update, params: {id: run.to_param, run: valid_attributes}, session: valid_session
          expect(assigns(:run)).to eq(run)
        end

        it "redirects to the run" do
          run = Run.create! valid_attributes
          put :update, params: {id: run.to_param, run: valid_attributes}, session: valid_session
          expect(response).to redirect_to(run)
        end
      end

      context "with invalid params" do
        it "assigns the run as @run" do
          run = Run.create! valid_attributes
          put :update, params: {id: run.to_param, run: invalid_attributes}, session: valid_session
          expect(assigns(:run)).to eq(run)
        end

        it "re-renders the 'edit' template" do
          run = Run.create! valid_attributes
          put :update, params: {id: run.to_param, run: invalid_attributes}, session: valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested run" do
        run = Run.create! valid_attributes
        expect {
          delete :destroy, params: {id: run.to_param}, session: valid_session
        }.to change(Run, :count).by(-1)
      end

      it "redirects to the runs list" do
        run = Run.create! valid_attributes
        delete :destroy, params: {id: run.to_param}, session: valid_session
        expect(response).to redirect_to(runs_url)
      end
    end
  end
end
