require 'rails_helper'

describe PostSerializer do
  let(:post) { build(:post, id: 1) }
  subject do
    JSON.parse described_class.new(post).to_json
  end

  describe '#id' do
    it { expect(subject['id']).to eq post.id }
  end

  describe '#title' do
    it { expect(subject['title']).to eq post.title }
  end

  describe '#body' do
    it { expect(subject['body']).to eq post.body }
  end

  describe '#user' do
    context 'when user is absent' do
      it { expect(subject['user']).to eq nil }
    end

    context 'when user is present' do
      let(:user) { create(:user) }
      let(:post) { create(:post, user: user) }

      before do
        expect(UserSerializer).to receive(:new).with(user, {:serializer_context_class=>PostSerializer}).and_call_original
      end

      it { expect(subject['user']).to be_present }
      # it { expect(subject['user']['id']).to eq(user.id) }
      # it { expect(subject['user']['name']).to eq(user.name) }
    end
  end
end
