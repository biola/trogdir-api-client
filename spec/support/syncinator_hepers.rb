module SyncinatorHelpers
  def self.access_id
    1000000000000000000
  end

  def self.secret_key
    'h3VpTrPDx2VWVJCilCFTDNKPCBJgbDZbfjj6I1+3Baf5KA5HMrCoEqTYriBIT+dXk/7LkryXNe4oeAZBV1XhRg=='
  end

  def create_current_syncinator
    Syncinator.create name: 'trogdir_api_client', access_id: SyncinatorHelpers.access_id, secret_key: SyncinatorHelpers.secret_key
  end
end