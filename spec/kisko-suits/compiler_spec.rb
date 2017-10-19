require "kisko-suits/compiler"

describe KiskoSuits::Compiler do
  subject { KiskoSuits::Compiler.new(filename) }

  describe "#render" do
    context "with suits file" do
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

    context "with suits file with variables" do
      let(:filename) { "data/preso_with_variables.md.suits" }

      it "creates output file" do
        subject.render
        output = File.read("data/preso_with_variables.md")
        expected_output = File.read("data/preso_with_variables.md_proper")
        expect(output).to eq(expected_output)
      end

      after do
        File.delete("data/preso_with_variables.md")
      end
    end
  end
end
