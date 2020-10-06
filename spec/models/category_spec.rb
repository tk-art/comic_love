require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }

  it 'nameがあれば、有効' do
    expect(category).to be_valid
  end

  it 'nameがなければ、無効' do
    category.name = ''
    expect(category).not_to be_valid
  end
end
