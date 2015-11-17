RSpec.describe ActsAsMultilingual::Builder do
  let(:klass) { User }
  let(:columns) { %w(first_name last_name) }
  let(:object) { subject.klass.new }
  let(:attr_name) { subject.columns.sample }

  subject { described_class.new(klass, *columns) }

  it 'has options' do
    expect(subject.options).to be
  end

  describe '#check_columns!' do
    context 'when column is missing' do
      let(:columns) { %w(hola) }

      it 'raises an error' do
        expect { subject }
          .to raise_error(ActsAsMultilingual::Exceptions::MissingColumn)
      end
    end
  end

  describe '#define_accessors' do
    it 'defines getters' do
      expect(object).to respond_to(attr_name)
    end

    it 'defines setters' do
      expect(object).to respond_to("#{attr_name}=")
    end
  end

  describe '#define_reader' do
    it 'instantiates cache' do
      object.send(attr_name)
      expect(object.instance_variable_get('@_acts_as_multilingual_cache')).to be
    end

    it 'reads value properly' do
      val = 'hey'
      object.send("#{attr_name}=", val)
      expect(object.send(attr_name)).to eq(val)
    end
  end

  describe '#define_writer' do
    it 'instantiates cache' do
      object.send("#{attr_name}=", 'hello')
      expect(object.instance_variable_get('@_acts_as_multilingual_cache')).to be
    end

    it 'writes value properly' do
      val = 'hoi'
      expect { object.send("#{attr_name}=", val) }
        .to change { object.send(attr_name) }.to(val)
    end
  end
end
