RSpec.describe ActsAsMultilingual::AttributeProxy do
  let(:owner) { User.new }
  let(:column) { :first_name }

  subject { described_class.new(owner, column) }

  describe '#read' do
    # ...
  end

  describe '#write' do
    # ...
  end
end
