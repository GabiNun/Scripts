Latest = (irm https://launchermeta.mojang.com/mc/game/version_manifest.json).versions.url[0]

irm (irm $Latest).downloads.server.url -Out Server

java -jar Server nogui
