cask "relic" do
  version "1.0.44"
  sha256 "0076e7f41b0101ca7e1933f6885f2ae2f28d61f6be729250676f61bb0e3b2493"

  url "https://relic.space/download/macos/relic-#{version}.dmg"
  name "Relic"
  desc "Local-first, end-to-end encrypted vault for everything you copy"
  homepage "https://relic.space/"

  livecheck do
    url "https://relic.space/latest.json"
    strategy :json do |json|
      json.dig("platforms", "macos", "version")
    end
  end

  # Relic checks latest.json and replaces its own bundle in place
  # (app/lib/data/self_update.dart), so brew is not the only update path.
  auto_updates true
  # Apple silicon only: app/macos/Runner.xcodeproj sets ARCHS = arm64 on the
  # Release configuration, and build_release_macos.sh bundles the osx-arm64
  # ONNX Runtime dylib that the sift search sidecar loads.
  depends_on arch: :arm64
  # MACOSX_DEPLOYMENT_TARGET = 11.0 in the Release configuration.
  depends_on macos: :big_sur

  # build_release_macos.sh renames the build product relic_app.app to Relic.app
  # when it stages the disk image, so this is the name inside the DMG.
  app "Relic.app"

  # Relic lives in the menu bar and keeps running after its window closes, so
  # quit it before the bundle is moved to the Trash.
  uninstall quit: "space.relic.mac"

  zap trash: [
    # The vault itself: db, blobs, config, prefs, logs. Hardcoded in
    # app/lib/platform/paths.dart so the relic CLI shim finds the same vault.
    "~/Library/Application Support/relic",
    # path_provider's per-bundle-id directory, used by worker_repo.dart for the
    # sync cache and the per-account personal db.
    "~/Library/Application Support/space.relic.mac",
    "~/Library/Caches/space.relic.mac",
    "~/Library/HTTPStorages/space.relic.mac",
    "~/Library/Preferences/space.relic.mac.plist",
    "~/Library/Saved Application State/space.relic.mac.savedState",
  ]
end
