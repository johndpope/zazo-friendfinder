class ResqueWorker::UpdateOwnerContactsOnly
  @queue = :update_contacts

  def self.perform(owner_mkey)
    WriteLog.info(self, "resque job was executed for owner_mkey=#{owner_mkey}")
    Contact::SetZazoInfoByOwner.new(owner_mkey).do
  end
end