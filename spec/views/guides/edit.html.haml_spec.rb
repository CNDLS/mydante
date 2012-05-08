require 'spec_helper'

describe "guides/edit" do
  before(:each) do
    @guide = assign(:guide, stub_model(Guide))
  end

  it "renders the edit guide form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => guides_path(@guide), :method => "post" do
    end
  end
end
