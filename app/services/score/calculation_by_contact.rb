class Score::CalculationByContact
  attr_reader :contact

  def initialize(contact)
    @contact = contact
  end

  def do
    contact.total_score = save_scores_and_get_total
    contact.save
  end

  private

  def save_scores_and_get_total
    total_score = 0
    wrap_transaction do
      criteria.each do |calculated|
        score = Score.create!({
          contact: contact,
          name:  calculated[:name],
          value: calculated[:score]
        })
        total_score += score.value
      end
    end
    total_score < 0 ? 0 : total_score
  end

  def wrap_transaction
    Score.transaction { yield }
  end

  def criteria
    Score::ALLOWED_METHODS.map do |name|
      criterion = Classifier.new([:score, :criteria, name]).klass
      { name: name, score: criterion.new(contact).calculate_with_ratio }
    end
  end
end
