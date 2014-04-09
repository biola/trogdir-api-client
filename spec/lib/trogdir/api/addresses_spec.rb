require 'spec_helper'

describe Trogdir::APIClient::Addresses do
  let!(:syncinator) { create_current_syncinator }
  let(:person) { create :person }
  let(:address) { create :address, person: person, zip: '12345' }
  let(:client) { Trogdir::APIClient::Addresses.new }
  let(:params) { {} }
  let(:method_name) { :index }
  let(:method_call) { client.send method_name, params.merge(uuid: person.uuid) }

  subject { JSON.parse(method_call.perform.body) }

  describe '#index' do
    let!(:address_a) { create :address, person: person }
    let!(:address_b) { create :address, person: person }

    its(:length) { should eql 2 }
    its(:first) { should be_an_address }
    it { expect(subject.first['id']).to eql address_a.id.to_s }
    its(:last) { should be_an_address }
    it { expect(subject.last['id']).to eql address_b.id.to_s }
  end

  describe '#show' do
    let(:method_name) { :show }
    let(:params) { {address_id: address.id} }
    it { should be_an_address }
    it { expect(subject['id']).to eql address.id.to_s }
  end

  describe '#create' do
    let(:method_name) { :create }

    context 'without required params' do
      let(:params) { {type: 'home'} }
      it { expect { subject }.to raise_exception }
    end

    context 'with required params' do
      let(:params) { {type: 'home', street_1: 'The Stick'} }
      it { expect { subject }.to change { person.reload.addresses.count }.from(0).to 1 }
      it { should be_an_address }
    end
  end

  describe '#update' do
    let(:method_name) { :update }
    let(:params) { {address_id: address.id, zip: '67890'} }
    it { expect { subject }.to change { address.reload.zip }.from('12345').to '67890' }
    it { should be_an_address }
  end

  describe '#destroy' do
    let(:method_name) { :destroy }
    let(:params) { {address_id: address.id} }
    before { address } # eager-create address

    it { expect { subject }.to change { person.reload.addresses.count }.from(1).to 0 }
    it { should be_an_address }
  end
end