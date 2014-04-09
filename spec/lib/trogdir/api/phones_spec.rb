require 'spec_helper'

describe Trogdir::APIClient::Phones do
  let!(:syncinator) { create_current_syncinator }
  let(:person) { create :person }
  let(:phone) { create :phone, person: person, number: '1231231234' }
  let(:client) { Trogdir::APIClient::Phones.new }
  let(:params) { {} }
  let(:method_name) { :index }
  let(:method_call) { client.send method_name, params.merge(uuid: person.uuid) }

  subject { JSON.parse(method_call.perform.body) }

  describe '#index' do
    let!(:phone_a) { create :phone, person: person }
    let!(:phone_b) { create :phone, person: person }

    its(:length) { should eql 2 }
    its(:first) { should be_a_phone }
    it { expect(subject.first['id']).to eql phone_a.id.to_s }
    its(:last) { should be_a_phone }
    it { expect(subject.last['id']).to eql phone_b.id.to_s }
  end

  describe '#show' do
    let(:method_name) { :show }
    let(:params) { {phone_id: phone.id} }
    it { should be_a_phone }
    it { expect(subject['id']).to eql phone.id.to_s }
  end

  describe '#create' do
    let(:method_name) { :create }

    context 'without required params' do
      let(:params) { {type: 'cell'} }
      it { expect { subject }.to raise_exception }
    end

    context 'with required params' do
      let(:params) { {type: 'home', number: '4564564567'} }
      it { expect { subject }.to change { person.reload.phones.count }.from(0).to 1 }
      it { should be_a_phone }
    end
  end

  describe '#update' do
    let(:method_name) { :update }
    let(:params) { {phone_id: phone.id, primary: true} }
    it { expect { subject }.to change { phone.reload.primary }.from(false).to true }
    it { should be_a_phone }
  end

  describe '#destroy' do
    let(:method_name) { :destroy }
    let(:params) { {phone_id: phone.id} }
    before { phone } # eager-create phone

    it { expect { subject }.to change { person.reload.phones.count }.from(1).to 0 }
    it { should be_a_phone }
  end
end