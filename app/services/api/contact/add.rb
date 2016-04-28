class Api::Contact::Add < Api::BaseHandler
  params_validation id: { type: String }

  def do_safe
    id = raw_params['id']
    contact = ::Contact.find_by_id(id)

    validations = CommonValidations.new(self)
    validations.validate_contact_presence(contact, "not found by id=#{id}")
    validations.validate_contact_ownership(contact, "you are not owner of contact id=#{id}")

    instance = ::Contact::Add.new(contact, caller: :api)
    instance.phone_number = raw_params['phone_number']
    @data = instance.do
  end
end
