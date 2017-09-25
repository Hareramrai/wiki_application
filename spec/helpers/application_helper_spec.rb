require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ArticlesHelper. For example:
#
# describe ArticlesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do

  describe '#format_time' do
    it 'returns time in string format' do
      time = Time.at 1506275369 
      expect(helper.format_time(time)).to eq(' Sunday, 24 Sep 2017 11:19 PM')
    end
  end

  describe '#time_with_icon' do
    it 'returns time in string format with icon' do
      time = Time.at 1506275369 
      expect(helper.time_with_icon(time)).to eq('<i class="glyphicon glyphicon-calendar"></i> Sunday, 24 Sep 2017 11:19 PM')
    end
  end

  describe '#email_with_icon' do
    it 'returns email with icon' do 
      expect(helper.email_with_icon('email@mail.com')).to eq('<i class="glyphicon glyphicon-user"></i> By email@mail.com')
    end
  end

  describe '#article_count' do
    it 'returns tag with article count' do 
      tag = class_double("Tag", name: 'Test', count: 250)
      expect(helper.article_count(tag)).to eq('Test  <span class="badge badge-info">250</span>')
    end
  end

  describe '#markdown' do
    it 'returns markdown code in highlighted format' do 
      text = <<-eos
        ````ruby
          class Welcom 

          end
        ````
      eos
      expect(helper.markdown(text)).to include("<p>", "</p>")
    end
  end

end
