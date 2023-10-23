class DueDateNotificationJob
    include Sidekiq::Worker
  
    def perform
      due_date = Date.tomorrow
      book_loans = BookLoan.checked_out.where(due_date: due_date)
  
      book_loans.each do |book_loan|
        UserMailer.due_date_notification_email(book_loan).deliver_now
      end
    end
  end