class Smux < Formula
  desc "Tmux session manager with fzf-powered project and template selection"
  homepage "https://github.com/Aietes/smux"
  url "https://github.com/Aietes/smux/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "81b31fdb021c5ed3c11806e98312430bc5ba2985096cca39ad9416a3bf4212b0"
  license "MIT"
  head "https://github.com/Aietes/smux.git", branch: "main"

  depends_on "rust" => :build
  depends_on "fzf"
  depends_on "tmux"

  def install
    system "cargo", "install", *std_cargo_args

    mkdir "completions" do
      system bin/"smux", "completions", "zsh", "--dir", "."
      zsh_completion.install "_smux"
    end

    mkdir "manpages" do
      system bin/"smux", "man", "--dir", "."
      man1.install Dir["*.1"]
      man5.install Dir["*.5"]
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/smux --version")
  end
end
