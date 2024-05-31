# frozen_string_literal: true

RSpec.describe Api::V1::ContentsController, type: :controller do
  let!(:user) { build(:user) }
  let(:user1) { create(:user) }
  let(:title) { "Test title" }
  let(:body) { "Test long body" }
  let(:content_attributes) { {title:, body:} }

  shared_context "authenticated user" do
    before do
      user.save!
      allow_any_instance_of(Api::V1::ContentsController).to receive(:authenticated_user).and_return(user)
    end
  end

  shared_context "unauthenticated user" do
    before do
      allow_any_instance_of(Api::V1::ContentsController).to receive(:authenticated_user).and_return(nil)
    end
  end

  shared_examples "unauthorized response" do
    it "returns unauthorized http status in response" do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET #list" do
    subject(:list) { get :list, as: :json }

    before do
      create_list(:content, 3, user:)
      list
    end

    it "returns successful response" do
      expect(response).to be_successful
    end

    it "returns all contents" do
      json_response = JSON.parse(response.body)

      expect(json_response["data"].length).to be(3)
    end
  end

  describe "POST #create" do
    subject(:create) { post :create, params: {content: content_attributes}, as: :json }

    context "when user is not authenticated" do
      include_context "unauthenticated user"
      before { create }

      it_behaves_like "unauthorized response"
    end

    context "when user is authenticated" do
      include_context "authenticated user"

      context "when parameter is invalid" do
        context "when title is nil" do
          let(:title) { nil }
          let(:error_message) { {message: ["Title can't be blank"]}.to_json }

          it "content is not created" do
            expect { create }.not_to change(Content, :count)
          end

          it "returns unprocessable_entity status in response" do
            create

            expect(response).to have_http_status(:unprocessable_entity)
          end

          it "returns error message in response body" do
            create

            expect(response.body).to eq(error_message)
          end
        end
      end

      context "when parameter is valid" do
        it "creates content" do
          expect { create }.to change(Content, :count).by(1)
        end

        it "returns created status in response" do
          create

          expect(response).to have_http_status(:created)
        end

        it "returns recent content in response body" do
          create

          json_response = JSON.parse(response.body)

          expect(json_response.dig("data", "attributes", "title")).to eq(title)
          expect(json_response.dig("data", "attributes", "body")).to eq(body)
        end
      end
    end
  end

  describe "PUT #update" do
    subject(:update_content) { put :update, params: {id: content.id, content: content_attributes}, as: :json }

    let(:title) { "Updated title" }
    let!(:content) { create(:content, user:) }

    context "when user is not authenticated" do
      include_context "unauthenticated user"
      before { update_content }

      it_behaves_like "unauthorized response"
    end

    context "when user is authenticated" do
      context "when user update other user content" do
        let!(:content) { create(:content, user: user1) }

        before { update_content }

        it_behaves_like "unauthorized response"
      end

      context "when user updates own content" do
        include_context "authenticated user"

        it "content count does not change" do
          expect { update_content }.to change(Content, :count).by(0)
        end

        it "returns recent content in response body" do
          update_content

          json_response = JSON.parse(response.body)

          expect(json_response.dig("data", "attributes", "title")).to eq(title)
          expect(json_response.dig("data", "attributes", "body")).to eq(body)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:destroy_content) { delete :destroy, params: {id: content.id}, as: :json }

    let!(:content) { create(:content, user:) }

    context "when user is not authenticated" do
      include_context "unauthenticated user"
      before { destroy_content }

      it_behaves_like "unauthorized response"
    end

    context "when user is authenticated" do
      context "when user deletes other user content" do
        let!(:content) { create(:content, user: user1) }

        before { destroy_content }

        it_behaves_like "unauthorized response"
      end

      context "when user deletes own content" do
        include_context "authenticated user"

        it "destroys the requested content" do
          expect { destroy_content }.to change(Content, :count).by(-1)
        end

        it "returns success message in response body" do
          destroy_content

          expect(JSON.parse(response.body)).to eql({"message" => "Deleted"})
        end
      end
    end
  end
end
