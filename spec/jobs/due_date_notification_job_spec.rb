require 'rails_helper'

RSpec.describe DueDateNotificationJob, type: :job do
  it 'sends due date notifications for book loans that are due tomorrow' do
    book_loan = create(:book_loan, due_date: Date.tomorrow)
    
    expect {
      DueDateNotificationJob.perform_now
    }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'does not send notifications for book loans that are not due tomorrow' do
    book_loan = create(:book_loan, due_date: Date.today)

    expect {
      DueDateNotificationJob.perform_now
    }.to_not change { ActionMailer::Base.deliveries.count }
  end
end