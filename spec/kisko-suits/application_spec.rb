require "kisko-suits"
require "open3"
require "fileutils"

describe KiskoSuits::Compiler do
  let(:working_dir) { File.dirname(__FILE__) + "/../.." }

  let(:good_config) { "#{working_dir}/data/preso.md.suits" }
  let(:bad_config) { "#{working_dir}/data/fail.md.suits" }
  let(:good_output) { "#{working_dir}/data/preso.md" }
  let(:bad_output) { "#{working_dir}/data/fail.md" }
  let(:proper_output) { "#{working_dir}/data/preso.md_proper" }

  describe "incorrect filename" do
    it "gives sensible error" do
      ksuits_out, ksuits_err, ksuits_process = Open3.capture3("kisko-suits some_invalid_file")

      expect(ksuits_err).to match(/Usage:/)
    end
  end

  describe "with complex config" do
    it "works" do
      ksuits_out, ksuits_err, ksuits_process = Open3.capture3("kisko-suits #{good_config}")

      expect(FileUtils.compare_file(good_output, proper_output)).to eq true
    end

    after do
      File.delete(good_output)
    end
  end

  describe "with missing include" do
    it "gives error message" do
      ksuits_out, ksuits_err, ksuits_process = Open3.capture3("kisko-suits #{bad_config}")

      expect(ksuits_out).to match(/can't be found/)
    end

    after do
      File.delete(bad_output)
    end
  end
end
