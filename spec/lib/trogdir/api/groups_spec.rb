require 'spec_helper'

describe Trogdir::APIClient::Groups do
  let!(:syncinator) { create_current_syncinator }
  let(:client) { Trogdir::APIClient::Groups.new }
  let(:group) { 'nobodies' }
  let(:identifier) { }
  let(:type) { }
  let(:method_name) { :people }
  let(:method_call) { client.send method_name, group: group, identifier: identifier, type: type }

  subject { JSON.parse(method_call.perform.body) }

  describe '#people' do
    context 'with an empty group' do
      it { should eql [] }
    end

    context 'with people in the gruop' do
      let!(:person_a) { create :person, groups: ['nobodies'] }
      let!(:person_b) { create :person, groups: ['nobodies', 'somebodies'] }

      its(:length) { should eql 2 }
      it 'has the right people' do
        expect(subject.map{|j| j['uuid']}).to eql [person_a.uuid, person_b.uuid]
      end
    end
  end

  describe '#add' do
    let(:method_name) { :add }
    let(:identifier) { person.uuid }

    context 'when the person is already in the group' do
      let(:person) { create :person, groups: ['nobodies'] }

      it { expect(subject['result']).to be false }
      it { expect { subject }.to_not change { person.reload.groups } }
    end

    context 'when the person is not already in the group' do
      let(:person) { create :person, groups: ['somebodies'] }

      it { expect(subject['result']).to be true }
      it { expect { subject }.to change { person.reload.groups }.from(['somebodies']).to ['somebodies', 'nobodies'] }
    end
  end

  describe '#remove' do
    let(:method_name) { :remove }
    let(:identifier) { person.uuid }

    context 'when the person is in the group' do
      let(:person) { create :person, groups: ['somebodies', 'nobodies'] }

      it { expect(subject['result']).to be true }
      it { expect { subject }.to change { person.reload.groups }.from(['somebodies', 'nobodies']).to ['somebodies'] }
    end

    context 'when the person is not in the group' do
      let(:person) { create :person, groups: ['somebodies'] }

      it { expect(subject['result']).to be false }
      it { expect { subject }.to_not change { person.reload.groups } }
    end
  end
end
