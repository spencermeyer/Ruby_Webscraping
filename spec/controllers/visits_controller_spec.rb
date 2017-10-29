require 'rails_helper'

RSpec.describe VisitsController, type: :controller do
  skip 'no valid visits controller tests yet :(' do
    # This should return the minimal set of attributes required to create a valid
    # Visit. As you add validations to Visit, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) {
      skip("Add a hash of attributes valid for your model")
    }

    let(:invalid_attributes) {
      skip("Add a hash of attributes invalid for your model")
    }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # VisitsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET #index" do
      it "assigns all visits as @visits" do
        visit = Visit.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(assigns(:visits)).to eq([visit])
      end
    end

    describe "GET #show" do
      it "assigns the requested visit as @visit" do
        visit = Visit.create! valid_attributes
        get :show, params: {id: visit.to_param}, session: valid_session
        expect(assigns(:visit)).to eq(visit)
      end
    end

    describe "GET #new" do
      it "assigns a new visit as @visit" do
        get :new, params: {}, session: valid_session
        expect(assigns(:visit)).to be_a_new(Visit)
      end
    end

    describe "GET #edit" do
      it "assigns the requested visit as @visit" do
        visit = Visit.create! valid_attributes
        get :edit, params: {id: visit.to_param}, session: valid_session
        expect(assigns(:visit)).to eq(visit)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Visit" do
          expect {
            post :create, params: {visit: valid_attributes}, session: valid_session
          }.to change(Visit, :count).by(1)
        end

        it "assigns a newly created visit as @visit" do
          post :create, params: {visit: valid_attributes}, session: valid_session
          expect(assigns(:visit)).to be_a(Visit)
          expect(assigns(:visit)).to be_persisted
        end

        it "redirects to the created visit" do
          post :create, params: {visit: valid_attributes}, session: valid_session
          expect(response).to redirect_to(Visit.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved visit as @visit" do
          post :create, params: {visit: invalid_attributes}, session: valid_session
          expect(assigns(:visit)).to be_a_new(Visit)
        end

        it "re-renders the 'new' template" do
          post :create, params: {visit: invalid_attributes}, session: valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          skip("Add a hash of attributes valid for your model")
        }

        it "updates the requested visit" do
          visit = Visit.create! valid_attributes
          put :update, params: {id: visit.to_param, visit: new_attributes}, session: valid_session
          visit.reload
          skip("Add assertions for updated state")
        end

        it "assigns the requested visit as @visit" do
          visit = Visit.create! valid_attributes
          put :update, params: {id: visit.to_param, visit: valid_attributes}, session: valid_session
          expect(assigns(:visit)).to eq(visit)
        end

        it "redirects to the visit" do
          visit = Visit.create! valid_attributes
          put :update, params: {id: visit.to_param, visit: valid_attributes}, session: valid_session
          expect(response).to redirect_to(visit)
        end
      end

      context "with invalid params" do
        it "assigns the visit as @visit" do
          visit = Visit.create! valid_attributes
          put :update, params: {id: visit.to_param, visit: invalid_attributes}, session: valid_session
          expect(assigns(:visit)).to eq(visit)
        end

        it "re-renders the 'edit' template" do
          visit = Visit.create! valid_attributes
          put :update, params: {id: visit.to_param, visit: invalid_attributes}, session: valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested visit" do
        visit = Visit.create! valid_attributes
        expect {
          delete :destroy, params: {id: visit.to_param}, session: valid_session
        }.to change(Visit, :count).by(-1)
      end

      it "redirects to the visits list" do
        visit = Visit.create! valid_attributes
        delete :destroy, params: {id: visit.to_param}, session: valid_session
        expect(response).to redirect_to(visits_url)
      end
    end
  end
end
