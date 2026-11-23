# Homebrew cask template. The release workflow fills in 0.3.0/181448c2cb28bbbee083567177256fac0de53023df1ff84bada0823fb6c69b30
# and pushes the result to mxab/homebrew-tap as Casks/fluxshot.rb.
cask "fluxshot" do
  version "0.3.0"
  sha256 "181448c2cb28bbbee083567177256fac0de53023df1ff84bada0823fb6c69b30"

  url "https://github.com/mxab/fluxshot/releases/download/v#{version}/fluxshot_#{version}_darwin_universal_app.zip"
  name "FluxShot"
  desc "Tiny, fast screenshot and annotation tool"
  homepage "https://github.com/mxab/fluxshot"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "FluxShot.app"
  # The CLI is the binary inside the bundle, so both share the app's
  # Screen Recording permission.
  binary "#{appdir}/FluxShot.app/Contents/MacOS/fluxshot"

  # Only ad-hoc signed (not notarized) for now: without this Gatekeeper
  # refuses to open a quarantined download.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/FluxShot.app"]
  end

  uninstall launchctl: "FluxShot",
            quit:      "io.github.mxab.fluxshot"

  zap trash: [
    "~/Library/Application Support/fluxshot",
    "~/Library/Caches/fluxshot",
    "~/Library/LaunchAgents/FluxShot.plist",
  ]
end
