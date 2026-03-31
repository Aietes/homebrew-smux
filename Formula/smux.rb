class Smux < Formula
  desc "Tmux session manager with fzf-powered project and template selection"
  homepage "https://github.com/Aietes/smux"
  url "https://github.com/Aietes/smux/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "938aad40a6c8bd4f007e7243fe7270006902274cc5277fb5b1f125b006c25ae9"
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
