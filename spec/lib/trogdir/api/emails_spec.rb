require 'spec_helper'

describe Trogdir::APIClient::Emails do
  let!(:syncinator) { create_current_syncinator }
  let(:person) { create :person }
  let(:email) { create :email, person: person, address: 'strong.bad@aol.com' }
  let(:client) { Trogdir::APIClient::Emails.new }
  let(:params) { {} }
  let(:method_name) { :index }
  let(:method_call) { client.send method_name, params.merge(uuid: person.uuid) }

  subject { JSON.parse(method_call.perform.body) }

  describe '#index' do
    let!(:email_a) { create :email, person: person }
    let!(:email_b) { create :email, person: person }

    its(:length) { should eql 2 }
    its(:first) { should be_an_email }
    it { expect(subject.first['id']).to eql email_a.id.to_s }
    its(:last) { should be_an_email }
    it { expect(subject.last['id']).to eql email_b.id.to_s }
  end

  describe '#show' do
    let(:method_name) { :show }
    let(:params) { {email_id: email.id} }
    it { should be_an_email }
    it { expect(subject['id']).to eql email.id.to_s }
  end

  describe '#create' do
    let(:method_name) { :create }

    context 'without required params' do
      let(:params) { {type: 'personal'} }
      it { expect { subject }.to raise_exception }
    end

    context 'with required params' do
      let(:params) { {type: 'university', address: 'the.cheat@example.com'} }
      it { expect { subject }.to change { person.reload.emails.count }.from(0).to 1 }
      it { should be_an_email }
    end
  end

  describe '#update' do
    let(:method_name) { :update }
    let(:params) { {email_id: email.id, primary: true} }
    it { expect { subject }.to change { email.reload.primary }.from(false).to true }
    it { should be_an_email }
  end

  describe '#destroy' do
    let(:method_name) { :destroy }
    let(:params) { {email_id: email.id} }
    before { email } # eager-create email

    it { expect { subject }.to change { person.reload.emails.count }.from(1).to 0 }
    it { should be_an_email }
  end
end