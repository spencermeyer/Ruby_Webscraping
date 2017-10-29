require 'rails_helper'

RSpec.describe ResultsController, type: :controller do
  skip 'no valid results controller tests yet :(' do
    # This should return the minimal set of attributes required to create a valid
    # Result. As you add validations to Result, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) {
      skip("Add a hash of attributes valid for your model")
    }

    let(:invalid_attributes) {
      skip("Add a hash of attributes invalid for your model")
    }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # ResultsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET #index" do
      it "assigns all results as @results" do
        result = Result.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(assigns(:results)).to eq([result])
      end
    end

    describe "GET #show" do
      it "assigns the requested result as @result" do
        result = Result.create! valid_attributes
        get :show, params: {id: result.to_param}, session: valid_session
        expect(assigns(:result)).to eq(result)
      end
    end

    describe "GET #new" do
      it "assigns a new result as @result" do
        get :new, params: {}, session: valid_session
        expect(assigns(:result)).to be_a_new(Result)
      end
    end

    describe "GET #edit" do
      it "assigns the requested result as @result" do
        result = Result.create! valid_attributes
        get :edit, params: {id: result.to_param}, session: valid_session
        expect(assigns(:result)).to eq(result)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Result" do
          expect {
            post :create, params: {result: valid_attributes}, session: valid_session
          }.to change(Result, :count).by(1)
        end

        it "assigns a newly created result as @result" do
          post :create, params: {result: valid_attributes}, session: valid_session
          expect(assigns(:result)).to be_a(Result)
          expect(assigns(:result)).to be_persisted
        end

        it "redirects to the created result" do
          post :create, params: {result: valid_attributes}, session: valid_session
          expect(response).to redirect_to(Result.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved result as @result" do
          post :create, params: {result: invalid_attributes}, session: valid_session
          expect(assigns(:result)).to be_a_new(Result)
        end

        it "re-renders the 'new' template" do
          post :create, params: {result: invalid_attributes}, session: valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          skip("Add a hash of attributes valid for your model")
        }

        it "updates the requested result" do
          result = Result.create! valid_attributes
          put :update, params: {id: result.to_param, result: new_attributes}, session: valid_session
          result.reload
          skip("Add assertions for updated state")
        end

        it "assigns the requested result as @result" do
          result = Result.create! valid_attributes
          put :update, params: {id: result.to_param, result: valid_attributes}, session: valid_session
          expect(assigns(:result)).to eq(result)
        end

        it "redirects to the result" do
          result = Result.create! valid_attributes
          put :update, params: {id: result.to_param, result: valid_attributes}, session: valid_session
          expect(response).to redirect_to(result)
        end
      end

      context "with invalid params" do
        it "assigns the result as @result" do
          result = Result.create! valid_attributes
          put :update, params: {id: result.to_param, result: invalid_attributes}, session: valid_session
          expect(assigns(:result)).to eq(result)
        end

        it "re-renders the 'edit' template" do
          result = Result.create! valid_attributes
          put :update, params: {id: result.to_param, result: invalid_attributes}, session: valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested result" do
        result = Result.create! valid_attributes
        expect {
          delete :destroy, params: {id: result.to_param}, session: valid_session
        }.to change(Result, :count).by(-1)
      end

      it "redirects to the results list" do
        result = Result.create! valid_attributes
        delete :destroy, params: {id: result.to_param}, session: valid_session
        expect(response).to redirect_to(results_url)
      end
    end
  end
end
