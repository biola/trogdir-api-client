require 'spec_helper'

describe Trogdir::APIClient::Photos do
  let!(:syncinator) { create_current_syncinator }
  let(:person) { create :person }
  let(:photo) { create :photo, person: person, url: 'http://example.com/a.jpg', width: 100 }
  let(:client) { Trogdir::APIClient::Photos.new }
  let(:params) { {} }
  let(:method_name) { :index }
  let(:method_call) { client.send method_name, params.merge(uuid: person.uuid) }

  subject { JSON.parse(method_call.perform.body) }

  describe '#index' do
    let!(:photo_a) { create :photo, person: person }
    let!(:photo_b) { create :photo, person: person }

    its(:length) { should eql 2 }
    its(:first) { should be_a_photo }
    it { expect(subject.first['id']).to eql photo_a.id.to_s }
    its(:last) { should be_a_photo }
    it { expect(subject.last['id']).to eql photo_b.id.to_s }
  end

  describe '#show' do
    let(:method_name) { :show }
    let(:params) { {photo_id: photo.id} }
    it { should be_a_photo }
    it { expect(subject['id']).to eql photo.id.to_s }
  end

  describe '#create' do
    let(:method_name) { :create }

    context 'without required params' do
      let(:params) { {type: 'id_card'} }
      it { expect { subject }.to raise_exception }
    end

    context 'with required params' do
      let(:params) { {type: 'id_card', url: 'http://example.com/b.jpg', height: 10, width: 20} }
      it { expect { subject }.to change { person.reload.photos.count }.from(0).to 1 }
      it { should be_a_photo }
    end
  end

  describe '#update' do
    let(:method_name) { :update }
    let(:params) { {photo_id: photo.id, width: 101} }
    it { expect { subject }.to change { photo.reload.width }.from(100).to 101 }
    it { should be_a_photo }
  end

  describe '#destroy' do
    let(:method_name) { :destroy }
    let(:params) { {photo_id: photo.id} }
    before { photo } # eager-create photo

    it { expect { subject }.to change { person.reload.photos.count }.from(1).to 0 }
    it { should be_a_photo }
  end
end