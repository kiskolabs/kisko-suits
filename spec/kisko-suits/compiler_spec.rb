require "kisko-suits/compiler"

describe KiskoSuits::Compiler do
  subject { KiskoSuits::Compiler.new(filename) }

  describe "#render" do
    let(:filename) { "data/preso.md.suits" }

    it "creates output file" do
      subject.render
      output = File.read("data/preso.md")
      expected_output = File.read("data/preso.md_proper")
      expect(output).to eq(expected_output)
    end

    after do
      File.delete("data/preso.md")
    end
  end
end
