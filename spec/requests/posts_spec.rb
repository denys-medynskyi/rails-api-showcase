require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.describe 'Posts', type: :request do

  # This should return the minimal set of attributes required to create a valid
  # Post. As you add validations to Post, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    build(:post).attributes
  }

  let(:invalid_attributes) {
    {'title' => ''}
  }

  def parsed_body
    JSON.parse(response.body)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PostsController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  let(:post_instance) { create(:post) }

  describe "GET #index" do
    it "assigns all post_instances as @post_instances" do
      expect(ActiveModel::Serializer::CollectionSerializer).to receive(:new).with([post_instance], {:namespace=>nil, :scope=>nil, :scope_name=>:current_user}).and_call_original

      get '/posts', params: {}
    end
  end

  describe "GET #show" do
    it "assigns the requested post_instance as @post_instance" do
      # expect(controller).to receive(:find_post) { post_instance }
      # expect(PostSerializer).to receive(:new).with(post_instance).and_call_original
      expect(PostSerializer).to receive(:new).with(post_instance, {:namespace=>nil, :scope=>nil, :scope_name=>:current_user}).and_call_original

      get '/posts', params: {id: post_instance.to_param}
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Post" do
        expect {
          post '/posts', params: {post: valid_attributes}
        }.to change(Post, :count).by(1)
      end

      it 'responds with 201' do
        post '/posts', params: {post: valid_attributes}
        expect(response.status).to eq(201)
      end
    end

    context "with invalid params" do
      it 'responds with errors' do
        post '/posts', params: {post: invalid_attributes}
        expect(parsed_body['errors']['body']).to be_present
        expect(parsed_body['errors']['title']).to be_present
      end

      it 'responds with 422' do
        post '/posts', params: {post: invalid_attributes}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it 'responds with 204' do
        post_instance
        put "/posts/#{post_instance.id}", params: { id: post_instance.id, post: valid_attributes}
        expect(response.status).to eq(200)
      end
    end

    context "with invalid params" do
      it 'responds with errors' do
        put "/posts/#{post_instance.id}", params: { id: post_instance.id, post: invalid_attributes}
        expect(parsed_body['title']).to be_present
      end

      it 'responds with 422' do
        put "/posts/#{post_instance.id}", params: { id: post_instance.id, post: invalid_attributes}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post_instance" do
      post_instance
      expect {
        delete "/posts/#{post_instance.id}", params: {id: post_instance.to_param}
      }.to change(Post, :count).by(-1)
    end

    it 'responds with 204' do
      delete "/posts/#{post_instance.id}", params: {id: post_instance.to_param}
      expect(response.status).to eq(204)
    end
  end

end
