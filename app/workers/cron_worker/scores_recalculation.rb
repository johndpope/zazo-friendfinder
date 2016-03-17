class CronWorker::ScoresRecalculation
  def self.perform
    WriteLog.info(self, 'cron job was executed')
    Contact.expired.each do |contact|
      contact.scores.destroy_all
      Score::CalculationByContact.new(contact).do
    end
  end
end