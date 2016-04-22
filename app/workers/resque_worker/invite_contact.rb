class ResqueWorker::InviteContact
  @queue = :update_contacts

  def self.perform(contact_id, caller)
    Zazo::Tools::Logger.info(self, "started; contact_id: #{contact_id}")
    contact = Contact.find(contact_id)
    Contact::Invite(contact, caller).do
  end
end
