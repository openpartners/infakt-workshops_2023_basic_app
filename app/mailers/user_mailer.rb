class UserMailer < ApplicationMailer
  def loan_created_email(book_loan)
    @title = book_loan.book.title
    @due_date = book_loan.due_date
    email_subject = "Nowe powiadomienie o ksiązce"
    mail(to: book_loan.user.email, subject: email_subject)
  end
end
