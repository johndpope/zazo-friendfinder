#
# update zazo_id, first_name, last_name and additions['marked_as_friend']
# this process will run periodically
#

class Contact::UpdateZazoInfo
  attr_reader :contact

  def initialize(contact)
    @contact = contact
  end

  def do
    contact.update_attributes(new_attrs) if contact.zazo_mkey && !attributes.empty?
    contact
  end

  private

  def new_attrs
    { zazo_id:    attributes['id'],
      first_name: attributes['first_name'],
      last_name:  attributes['last_name'],
      additions:  new_additions }
  end

  def new_additions
    (contact.additions || {}).merge('marked_as_friend' => contact_is_friend?)
  end

  def contact_is_friend?
    attributes['friends'].include?(contact.owner_mkey)
  end

  def attributes
    return @attributes if @attributes
    api_params = { user: contact.zazo_mkey, attrs: [:id, :first_name, :last_name, :friends] }
    @attributes = DataProviderApi.new(api_params).query(:attributes)
  rescue Faraday::ClientError
    {}
  end
end
