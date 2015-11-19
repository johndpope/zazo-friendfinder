class ContactDecorator < Draper::Decorator
  delegate_all

  def owner
    Owner.new object.owner
  end
end
