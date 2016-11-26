require 'rails_helper'

RSpec.describe "Posts", type: :request do

  let(:valid_attributes) {
    build(:post).attributes
  }

  describe "POST /posts" do
    it "responds with correct status" do
      post posts_path, params: { post: valid_attributes }
      expect(response).to have_http_status(201)
    end
  end
end
