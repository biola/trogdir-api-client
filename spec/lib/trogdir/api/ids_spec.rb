require 'spec_helper'

describe Trogdir::APIClient::IDs do
  let!(:syncinator) { create_current_syncinator }
  let(:person) { create :person }
  let(:id) { create :id, person: person, identifier: 'strongb0' }
  let(:client) { Trogdir::APIClient::IDs.new }
  let(:params) { {} }
  let(:method_name) { :index }
  let(:method_call) { client.send method_name, params.merge(uuid: person.uuid) }

  subject { JSON.parse(method_call.perform.body) }

  describe '#index' do
    let!(:id_a) { create :id, person: person }
    let!(:id_b) { create :id, person: person }

    its(:length) { should eql 2 }
    its(:first) { should be_an_id }
    it { expect(subject.first['id']).to eql id_a.id.to_s }
    its(:last) { should be_an_id }
    it { expect(subject.last['id']).to eql id_b.id.to_s }
  end

  describe '#show' do
    let(:method_name) { :show }
    let(:params) { {id_id: id.id} }
    it { should be_an_id }
    it { expect(subject['id']).to eql id.id.to_s }
  end

  describe '#create' do
    let(:method_name) { :create }

    context 'without required params' do
      let(:params) { {identifier: '12345'} }
      it { expect { subject }.to raise_exception }
    end

    context 'with required params' do
      let(:params) { {type: 'netid', identifier: 'poopsmitht0'} }
      it { expect { subject }.to change { person.reload.ids.count }.from(0).to 1 }
      it { should be_an_id }
    end
  end

  describe '#update' do
    let(:method_name) { :update }
    let(:params) { {id_id: id.id, identifier: 'senorc0'} }
    it { expect { subject }.to change { id.reload.identifier }.from('strongb0').to 'senorc0' }
    it { should be_an_id }
  end

  describe '#destroy' do
    let(:method_name) { :destroy }
    let(:params) { {id_id: id.id} }
    before { id } # eager-create ID

    it { expect { subject }.to change { person.reload.ids.count }.from(1).to 0 }
    it { should be_an_id }
  end
end