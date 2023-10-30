module Publishers
    class LoanBookPublisher
      def initialize(message)
        @message = message
      end
  
      def publish
        ::Publishers::Application.new(
          routing_key: 'basic_app.book_loans',  # Określ routing key, na który będziemy wysyłać wiadomość
          exchange_name: 'basic_app',           # Określ nazwę exchange, do którego będzie wysłana wiadomość
          message: @message
        ).publish
      end
    end
  end
  