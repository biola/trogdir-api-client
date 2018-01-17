require 'spec_helper'

describe Trogdir::APIClient::Accounts do
  let!(:syncinator) { create_current_syncinator }
  let(:person) { create :person }
  let(:account) { create :account, person: person, _type: 'UniversityAccount' }
  let(:client) { Trogdir::APIClient::Accounts.new }
  let(:params) { {} }
  let(:method_name) { :index }
  let(:method_call) { client.send method_name, params.merge(uuid: person.uuid) }

  subject { JSON.parse(method_call.perform.body) }

  describe '#index' do
    let!(:account_a) { create :account, person: person }
    let!(:account_b) { create :account, person: person }

    its(:length) { should eql 2 }
    its(:first) { should be_an_account }
    it { expect(subject.first['id']).to eql account_a.id.to_s }
    its(:last) { should be_an_account }
    it { expect(subject.last['id']).to eql account_b.id.to_s }
  end

  describe '#show' do
    let(:method_name) { :show }
    let(:params) { {account_id: account.id} }
    it { should be_an_account }
    it { expect(subject['id']).to eql account.id.to_s }
  end

  describe '#create' do
    let(:method_name) { :create }

    context 'without required params' do
      let(:params) { {} }
      it { expect { subject }.to raise_exception }
    end

    context 'with required params' do
      let(:params) { {_type: 'UniversityAccount'} }
      it { expect { subject }.to change { person.reload.accounts.count }.from(0).to 1 }
      it { should be_an_account }
    end
  end

  describe '#update' do
    let(:method_name) { :update }
    let(:params) { {account_id: account.id, modified_by: 'thisthat' } }
    it { expect { subject }.to change { account.reload.modified_by }.from(nil).to 'thisthat' }
    it { should be_an_account }
  end

  describe '#destroy' do
    let(:method_name) { :destroy }
    let(:params) { {account_id: account.id} }
    before { account } # eager-create account

    it { expect { subject }.to change { person.reload.accounts.count }.from(1).to 0 }
    it { should be_an_account }
  end
end
