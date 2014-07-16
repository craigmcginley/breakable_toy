require 'rails_helper'

describe PostsController do
  let(:post) { FactoryGirl.create(:post_with_family) }

  describe "DELETE destroy" do
    it "lets post owner delete post" do
      sign_in post.user

      delete :destroy, id: post.id

      expect(response).to be_a_redirect
      expect(Post.count).to eq(0)
    end

    it "lets family admin delete post" do
      FactoryGirl.create(:family_member, family: post.families.last, user: post.user, role: "member")
      admin_user = FactoryGirl.create(:user)
      FactoryGirl.create(:family_member, family: post.families.last, user: admin_user, role: "admin")
      sign_in admin_user

      delete :destroy, id: post.id

      expect(response).to be_a_redirect
      expect(Post.count).to eq(0)
    end

    it "prevents other users from deleting post" do
      other_user = FactoryGirl.create(:user)
      sign_in other_user

      expect { delete :destroy, id: post.id }.
        to raise_error(ActionController::RoutingError)
      expect(Post.count).to eq(1)
    end
  end
end
