# app/services/publishers/application.rb
require 'bunny'

module Publishers
  class Application
    def initialize(message:, exchange_name:, routing_key:)
      @message = message
      @exchange_name = exchange_name
      @routing_key = routing_key
    end

    def publish
      begin
        connection.start
        channel = connection.create_channel
        exchange = channel.direct(@exchange_name)
        exchange.publish(@message.to_json, routing_key: @routing_key)

        puts "Sent message: #{@message.to_json} to exchange: #{@exchange_name} with routing key: #{@routing_key}"

      rescue Bunny::Exception => e
        puts "Error: #{e.message}"
      ensure
        connection.close
      end
    end

    private

    def connection_options
      {
        host: "localhost",
        port: "5672",
        vhost: "/",
        username: "guest",
        password: "guest"
      }
    end

    def connection
      @connection ||= Bunny.new(connection_options).tap(&:start)
    end
  end
end
