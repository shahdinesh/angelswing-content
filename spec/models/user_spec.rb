# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe "validations" do
    subject(:user) { build(:user) }

    context "when the attributes are valid" do
      it "is valid" do
        expect(user).to be_valid
      end

      it "is saves the user" do
        user.save!
      end
    end

    context "when the attributes are not valid" do
      context "when first_name field is invalid" do
        context "when first_name is nil" do
          let(:error_message) do
            "Validation failed: First name can't be blank, First name can only contain letters and spaces"
          end

          before { user.first_name = nil }

          it "is invalid" do
            expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid, error_message)
          end
        end

        context "when first_name is contains invalid character" do
          let(:error_message) { "Validation failed: First name can only contain letters and spaces" }

          before { user.first_name = "#test" }

          it "is invalid" do
            expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid, error_message)
          end
        end
      end

      context "when email field is invalid" do
        context "when last_name is nil" do
          let(:error_message) do
            "Validation failed: Last name can't be blank, Last name can only contain letters and spaces"
          end

          before { user.last_name = nil }

          it "is invalid" do
            expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid, error_message)
          end
        end

        context "when last_name is contains invalid character" do
          let(:error_message) { "Validation failed: Last name can only contain letters and spaces" }

          before { user.last_name = "#test" }

          it "is invalid" do
            expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid, error_message)
          end
        end
      end

      context "when email field is invalid" do
        context "when email is nil" do
          let(:error_message) { "Validation failed: Email can't be blank, Email is invalid" }

          before { user.email = nil }

          it "is invalid" do
            expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid, error_message)
          end
        end

        context "when email is contains invalid character" do
          let(:error_message) { "Validation failed: Email is invalid" }

          before { user.email = "invalid email" }

          it "is invalid" do
            expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid, error_message)
          end
        end

        context "when email is contains invalid character" do
          let(:error_message) { "Validation failed: Email has already been taken" }
          let(:common_email) { "common@email.com" }
          let!(:user2) { create(:user, email: common_email) }

          before { user.email = common_email }

          it "is invalid" do
            expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid, error_message)
          end
        end
      end

      context "when password field is invalid" do
        context "when password is nil" do
          let(:error_message) { "Validation failed: Password can't be blank" }

          before { user.password = nil }

          it "is invalid" do
            expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid, error_message)
          end
        end
      end
    end
  end
end
