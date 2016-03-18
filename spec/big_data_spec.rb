RSpec.describe "Big Data" do

  before(:context) do
    report = ODFReport::Report.new("spec/big_data.odt") do |r|
      1_000.times do |i|
        r.replace_tag("field_#{ i }", "Field value of #{ i }")
      end
    end

    report.fast_generate("spec/result/specs.odt")

    @data = Inspector.new("spec/result/specs.odt")
  end


  it "simple fields replacement" do
    expect(@data.text).not_to match(/\[FIELD_1\]/)
    expect(@data.text).not_to match(/\[FIELD_2\]/)

    expect(@data.text).to match "Field value of 1"
    expect(@data.text).to match "Field value of 999"
  end
end
