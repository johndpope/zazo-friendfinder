class Contact::Cell < Cell::Concept
  include ServicesLinksHelper

  ATTRIBUTES = [:owner_mkey, :display_name, :zazo_id, :zazo_mkey, :total_score,
                :expires_at, :additions, :notified?, :created_at, :updated_at,
                :contact_links]

  class Table < Cell::Concept
    def show
      render
    end

    private

    def contacts
      model
    end

    def disable_owner_link?
      !!options[:disable_owner_link]
    end
  end

  property :id, :display_name, :zazo_id,
           :total_score, :expires_at, :vectors

  def show
    render
  end

  def table_row
    render :table_row
  end

  private

  def value(attr)
    respond_to?(attr, true) ? send(attr) : model.send(attr)
  end

  def owner_mkey
    disable_owner_link? ? model.owner_mkey : friendfinder_link(model.owner_mkey)
  end

  def zazo_mkey
    friendfinder_link(model.zazo_mkey)
  end

  def contact_links
    services_links(model.zazo_mkey)
  end

  #
  # options
  #

  def disable_owner_link?
    !!options[:disable_owner_link]
  end
end
