RSpec.describe ActsAsMultilingual::Extension do
  it 'extends AR methods' do
    expect(ActiveRecord::Base).to respond_to(:acts_as_multilingual)
  end

  it 'invokes builder' do
    expect(ActsAsMultilingual::Builder).to receive(:new)
    ActiveRecord::Base.acts_as_multilingual
  end
end
