require 'spec_helper'

describe Trogdir::APIClient::ChangeSyncs do
  let!(:syncinator) { create_current_syncinator }
  let(:client) { Trogdir::APIClient::ChangeSyncs.new }
  let(:params) { {} }
  let(:method_name) { :start }
  let(:method_call) { client.send method_name, params }

  subject { JSON.parse(method_call.perform.body) }

  describe '#start' do
    context 'without changelogs' do
      it { should eql [] }
    end

    context 'with changelogs' do
      let!(:change_sync_a) { create :change_sync, syncinator: syncinator }
      let!(:change_sync_b) { create :change_sync, syncinator: syncinator }

      its(:length) { should eql 2 }
      it { expect(subject.first['sync_log_id']).to eql change_sync_a.reload.sync_logs.first.id.to_s }
      it { expect(subject.last['sync_log_id']).to eql change_sync_b.reload.sync_logs.first.id.to_s }
      it { expect { subject }.to change { syncinator.startable_changesets.length }.from(2).to 0 }
    end
  end

  describe '#error' do
    let(:change_sync) { create :change_sync, syncinator: syncinator }
    let(:sync_log) { create :sync_log, change_sync: change_sync }
    let(:method_name) { :error }
    let(:params) { {sync_log_id: sync_log.id, message: 'Computer Over. Virus = Very Yes.'} }

    it { expect { subject }.to change { sync_log.reload.errored_at }.from(nil).to Time }
    it { expect { subject }.to change { sync_log.reload.message }.from(nil).to 'Computer Over. Virus = Very Yes.' }
  end

  describe '#finish' do
    let(:change_sync) { create :change_sync, syncinator: syncinator }
    let(:sync_log) { create :sync_log, change_sync: change_sync }
    let(:method_name) { :finish }
    let(:params) { {sync_log_id: sync_log.id, action: 'create', message: "It's in a better place"} }

    it { expect { subject }.to change { sync_log.reload.succeeded_at }.from(nil).to Time }
    it { expect { subject }.to change { sync_log.reload.action }.from(nil).to :create }
    it { expect { subject }.to change { sync_log.reload.message }.from(nil).to "It's in a better place" }
  end
end