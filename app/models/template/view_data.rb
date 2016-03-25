class Template::ViewData
  attr_reader :contact, :owner

  class ContactData
    attr_reader :name

    def initialize(contact)
      @name = contact.display_name
    end
  end

  def initialize(notification, contact = nil)
    contact ||= notification.contact
    @notification = notification
    @contact = ContactData.new(contact)
    @owner = contact.owner.fetch_data
  end

  def add_link
    action_link(:add)
  end

  def ignore_link
    action_link(:ignore)
  end

  def unsubscribe_link
    action_link(:unsubscribe)
  end

  private

  def action_link(type)
    "#{Figaro.env.friendfinder_base_url}/w/#{@notification.nkey}/#{type}"
  end
end
