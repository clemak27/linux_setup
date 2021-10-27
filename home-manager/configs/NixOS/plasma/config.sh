#!/bin/sh

kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'enableFloatingLayout' 'true'
kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'enableQuarterLayout' 'true'
kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'enableSpreadLayout' 'false'
kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'enableStairLayout' 'false'
kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'floatingClass' 'keepassxc,systemsettings,plasma.emojier'
kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'ignoreClass' 'krunner,yakuake,spectacle,kded5,steam'
kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'maximizeSoleTile' 'true'
kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'noTileBorder' 'true'
kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'preventMinimize' 'true'
kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'screenGapBottom' '7'
kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'screenGapLeft' '7'
kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'screenGapRight' '7'
kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'screenGapTop' '7'
kwriteconfig5 --file 'kwinrc' --group 'Script-bismuth' --key 'tileLayoutGap' '7'

kwriteconfig5 --file 'dolphinrc' --group 'DetailsMode' --key 'ExpandableFolders' 'false'
kwriteconfig5 --file 'dolphinrc' --group 'DetailsMode' --key 'FontWeight' '50'
kwriteconfig5 --file 'dolphinrc' --group 'DetailsMode' --key 'PreviewSize' '32'
kwriteconfig5 --file 'dolphinrc' --group 'General' --key 'ConfirmClosingMultipleTabs' 'false'
kwriteconfig5 --file 'dolphinrc' --group 'General' --key 'RememberOpenedTabs' 'false'
kwriteconfig5 --file 'dolphinrc' --group 'General' --key 'ShowZoomSlider' 'false'

kwriteconfig5 --file 'breezerc' --group 'Common' --key 'OutlineCloseButton' 'false'
kwriteconfig5 --file 'breezerc' --group 'Common' --key 'ShadowSize' 'ShadowSmall'

kwriteconfig5 --file 'plasmarc' --group 'Theme' --key 'name' 'breeze-alphablack'
