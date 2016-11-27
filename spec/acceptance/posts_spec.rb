require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Posts" do
  get "/posts" do
    example "Listing posts" do
      do_request

      expect(status).to eq 200
    end
  end

  post "/posts" do
    parameter :title, "Title for post", :required => true, :scope => :post
    parameter :body, "Body for post", required: true, :scope => :post

    let(:title) { Faker::Name.title }
    let(:body) { Faker::Lorem.paragraph }

    example "Creating an post" do
      do_request

      expect(params).to eq({
                           'post' => {
                               'title' => title,
                               'body' => body
                           }
                       })
    end
  end
end
