require 'spec_helper'

describe Trogdir::APIClient::People do
  let!(:syncinator) { create_current_syncinator }
  let(:person) { create :person, last_name: 'Bad' }
  let(:client) { Trogdir::APIClient::People.new }
  let(:method_call) { client.index }

  subject { JSON.parse(method_call.perform.body) }

  describe '#index' do
  let!(:person_a) { create :person, affiliations: ['employee'] }
  let!(:person_b) { create :person, affiliations: ['student'] }

    context 'without args' do
      its(:length) { should eql 2 }
      its(:first) { should be_a_person }
      it { expect(subject.first['uuid']).to eql person_a.uuid }
      its(:last) { should be_a_person }
      it { expect(subject.last['uuid']).to eql person_b.uuid }
    end

    context 'with affiliation arg' do
      let(:method_call) { client.index affiliation: 'student' }
      its(:length) { should eql 1 }
    end
  end

  describe '#show' do
    let(:method_call) { client.show(uuid: person.uuid) }
    it { should be_a_person }
    it { expect(subject['uuid']).to eql person.uuid }
  end

  describe '#by_id' do
    context 'without type arg' do
      before { create :id, person: person, identifier: 'johnd0', type: :netid }

      let(:method_call) { client.by_id(id: 'johnd0') }
      it { should be_a_person }
      it { expect(subject['uuid']).to eql person.uuid }
    end

    context 'with type arg' do
      before { create :id, person: person, identifier: '42', type: :biola_id }

      let(:method_call) { client.by_id(id: '42', type: 'biola_id') }
      it { should be_a_person }
      it { expect(subject['uuid']).to eql person.uuid }
    end
  end

  describe '#create' do
    let(:method_call) { client.create(params) }

    context 'without required params' do
      let(:params) { {first_name: 'Poopsmith', display_name: 'Poopsmith, The'} }
      it { expect { subject }.to raise_exception }
    end

    context 'with required params' do
      let(:params) { {first_name: 'Poopsmith', last_name: 'The'} }
      it { expect { subject }.to change { Person.count }.from(0).to 1 }
      it { should be_a_person }
    end
  end

  describe '#update' do
    let(:method_call) { client.update(params) }
    let(:params) { {uuid: person.uuid, last_name: 'Stinkoman'} }
    it { expect { subject }.to change { person.reload.last_name }.from('Bad').to 'Stinkoman' }
    it { should be_a_person }
  end
end