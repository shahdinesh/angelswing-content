# frozen_string_literal: true

RSpec.describe Content, type: :model do
  describe "validations" do
    subject(:content) { build(:content) }

    context "when the attributes are valid" do
      it "is valid" do
        expect(content).to be_valid
      end

      it "is saves the content" do
        content.save!
      end
    end

    context "when the attributes are not valid" do
      context "when title field is invalid" do
        context "when title is nil" do
          let(:error_message) { "Validation failed: Title can't be blank" }

          before { content.title = nil }

          it "is invalid" do
            expect { content.save! }.to raise_error(ActiveRecord::RecordInvalid, error_message)
          end
        end
      end

      context "when body field is invalid" do
        context "when body is nil" do
          let(:error_message) { "Validation failed: Body can't be blank" }

          before { content.body = nil }

          it "is invalid" do
            expect { content.save! }.to raise_error(ActiveRecord::RecordInvalid, error_message)
          end
        end
      end
    end
  end
end
