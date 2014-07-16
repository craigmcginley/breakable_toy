require "rails_helper"

describe CommentsController do
  let(:post) { FactoryGirl.create(:post_with_family) }

  describe "DELETE destroy" do
    it "lets comment owner delete comment" do
      comment = FactoryGirl.create(:comment, post: post)
      sign_in comment.user

      delete :destroy, id: comment.id

      expect(response).to be_a_redirect
      expect(Comment.count).to eq(0)
    end

    it "lets family admin delete comment" do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:family_member, family: post.families.last, user: user, role: "member")
      comment = FactoryGirl.create(:comment, post: post, user: user)
      admin_user = FactoryGirl.create(:user)
      FactoryGirl.create(:family_member, family: post.families.last, user: admin_user, role: "admin")
      sign_in admin_user

      delete :destroy, id: comment.id

      expect(response).to be_a_redirect
      expect(Comment.count).to eq(0)
    end

    it "prevents other users from deleting comments" do
      comment = FactoryGirl.create(:comment, post: post)
      other_user = FactoryGirl.create(:user)
      sign_in other_user

      expect { delete :destroy, id: comment.id }.
        to raise_error(ActionController::RoutingError)
      expect(Comment.count).to eq(1)
    end
  end
end
