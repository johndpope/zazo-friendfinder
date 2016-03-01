class Score::Criteria::FriendOfFriends < Score::Criteria::Base
  include Score::Criteria::Shared::ContactOf

  def self.ratio
    16
  end

  def calculate
    @friends = contact.zazo_mkey ? get_friends : []
    @friends.size
  end

  private

  def update_contact
    update_contact_additions contact, 'friends_who_are_friends_with_contact', @friends
  end

  def get_friends
    StatisticsApi.new(user_mkey: contact.owner.mkey, contact_mkey: contact.zazo_mkey).users :friends_are_friends_with_contact
  rescue Faraday::ClientError
    []
  end
end