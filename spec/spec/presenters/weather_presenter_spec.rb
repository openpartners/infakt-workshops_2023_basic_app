require 'rails_helper' # Upewnij się, że masz zainstalowany i skonfigurowany RSpec

RSpec.describe WeatherPresenter do
  # Przykładowe dane pogodowe do testów
  let(:sample_data) do
    {
      'current' => {
        'condition' => {
          'text' => 'Sunny',
          'icon' => 'sunny.png'
        },
        'temp_c' => 20
      }
    }
  end

  subject { described_class.new(sample_data) }

  describe '#description' do
    it 'returns the weather description' do
      expect(subject.description).to eq('Sunny')
    end
  end

  describe '#temperature' do
    it 'returns the temperature in Celsius' do
      expect(subject.temperature).to eq(20)
    end
  end

  describe '#icon' do
    it 'returns the weather icon' do
      expect(subject.icon).to eq('sunny.png')
    end
  end

  describe '#nice_weather?' do
    it 'returns true for "Sunny" weather' do
      expect(subject.nice_weather?).to be(true)
    end

    it 'returns false for "Rainy" weather' do
      subject.data['current']['condition']['text'] = 'Rainy'
      expect(subject.nice_weather?).to be(false)
    end
  end

  describe '#good_to_read_outside?' do
    it 'returns true for "Sunny" weather and temperature > 15' do
      expect(subject.good_to_read_outside?).to be(true)
    end

    it 'returns false for "Rainy" weather' do
      subject.data['current']['condition']['text'] = 'Rainy'
      expect(subject.good_to_read_outside?).to be(false)
    end

    it 'returns false for "Sunny" weather and temperature <= 15' do
      subject.data['current']['temp_c'] = 10
      expect(subject.good_to_read_outside?).to be(false)
    end
  end

  describe '#encourage_text' do
    it 'returns a positive message for good weather' do
      expect(subject.encourage_text).to eq("Get some snacks and go read a book in a park!")
    end

    it 'returns a general message for other weather conditions' do
      subject.data['current']['condition']['text'] = 'Rainy'
      expect(subject.encourage_text).to eq("It's always a good weather to read a book!")
    end
  end
end