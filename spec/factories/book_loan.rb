FactoryBot.define do
    factory :book_loan do
      user { create(:user) }
      book { create(:book) }
      due_date { Date.tomorrow }
    end
end