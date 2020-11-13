require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe '#flash_class_helper' do
    it 'returns the class corresponding to the flash type' do
      expect(flash_class_helper('notice')).to eq('success')
    end
  end

  describe '#flash_prefix_helper' do
    it 'returns the prefix corresponding to the flash type' do
      expect(flash_prefix_helper('notice')).to eq('Notice!')
    end
  end
end
