require 'rails_helper'

describe UserSerializer do
  let(:user) { build(:user, id: 1) }
  subject do
    JSON.parse described_class.new(user).to_json
  end

  describe '#id' do
    it { expect(subject['id']).to eq user.id }
  end

  describe '#name' do
    it { expect(subject['name']).to eq user.name }
  end

end
