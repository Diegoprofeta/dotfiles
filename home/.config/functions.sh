#!/usr/bin/env bash

source $HOME/.colors &>/dev/null

function f() {
  git fetch https://github.com/${1} ${2}
}

function p() {
  git cherry-pick ${1}
}

function cc() {
  git add . && git cherry-pick --continue
}

function a() {
  git cherry-pick --abort
}

function translate() {
  typing=$(mktemp)
  rm -rf $typing && nano $typing
  msg=$(trans -b :en -no-auto -i $typing)
  cat $typing
}

if [ $HOST = "vitor" ]; then
  function cm() {
    translate
    git add . && git commit --message $msg --signoff --author "vulkan-ops <vulkanops@gmail.com>" && git push -f
  }
  function c() {
    git add . && git commit --author "${1}" && git push -f
  }
  function amend() {
    git add . && git commit --signoff --amend && git push -f
  }
else
  function cm() {
    translate
    git add . && git commit --message $msg --signoff --author "vulkan-ops <vulkanops@gmail.com>" && git push -f
  }
  function c() {
    git add . && git commit --author "${1}"
  }
  function amend() {
    git add . && git commit --amend
  }
fi

function upd() {
  $HOME/.config/scripts/pacman-update.sh
}

function sshgen() {
  ssh-keygen -t ed25519 -C "vulkanops@gmail.com"
  eval "$(ssh-agent -s)" && ssh-add -l
  cat $HOME/.ssh/id_ed25519.pub | wl-copy
  xdg-open https://github.com/settings/ssh/new
}

#function wifi() {
#  interface=$(cat /proc/net/wireless | perl -ne '/(\w+):/ && print $1')
#  iwctl station $interface scan && sleep 3
#  iwctl station $interface get-networks
#  echo "${BLU}Which network do you want to connect to?${END} "; read wifi
#  iwctl station $interface connect "${wifi}"
#}

function fetch() {
  ./.dotfiles/home/.config/scripts/fetch.sh gnu
}

function vm () {
sudo systemctl enable --now tailscaled
sudo tailscale up
ssh vitor@100.110.145.82
}

function dt () {
#git clone  https://github.com/LineageOS/android_hardware_motorola -b lineage-19.0  hardware/motorola
git clone https://github.com/PixelExperience/external_bson  external/bson
git clone https://github.com/PixelExperience/system_qcom  system/qcom
git clone https://github.com/PixelExperience/hardware_qcom-caf_msm8996_display hardware/qcom-caf/msm8996/display
git clone https://github.com/PixelExperience/hardware_qcom-caf_msm8996_media hardware/qcom-caf/msm8996/media
git clone https://github.com/PixelExperience/hardware_qcom-caf_msm8996_audio hardware/qcom-caf/msm8996/audio
git clone --depth=1 https://github.com/kdrag0n/proton-clang.git prebuilts/clang/host/linux-x86/proton-clang
#git clone https://gitlab.com/crdroidandroid/android_vendor_gapps vendor/gapps
git clone https://github.com/PixelExperience/device_qcom_sepolicy-legacy-um  device/qcom/sepolicy-legacy-um
}

function cr () {
git clone https://github.com/vulkan-ops/device_motorola_channel -b 12.0  device/motorola/channel
git clone https://github.com/vulkan-ops/device_motorola_ocean  -b 12.0  device/motorola/ocean
git clone https://github.com/vulkan-ops/device_motorola_river  -b 12.0  device/motorola/river
git clone https://github.com/vulkan-ops/device_motorola_sdm632-common -b twelve  device/motorola/sdm632-common
git clone https://github.com/vulkan-ops/vendor_motorola_ocean   vendor/motorola/ocean
git clone https://github.com/vulkan-ops/vendor_motorola_channel   vendor/motorola/channel
git clone https://github.com/vulkan-ops/vendor_motorola_river   vendor/motorola/river
git clone https://github.com/vulkan-ops/vendor_motorola_sdm632-common  vendor/motorola/sdm632-common
git clone https://github.com/vulkan-ops/kernel_motorola_sdm632 -b twelve kernel/motorola/sdm632
}

function job () {
cd Downloads
mkdir github
cd github
git clone https://github.com/vulkan-ops/device_motorola_channel  channel-dt
git clone https://github.com/vulkan-ops/device_motorola_ocean    ocean-dt
git clone https://github.com/vulkan-ops/device_motorola_river    river-dt
git clone https://github.com/vulkan-ops/device_motorola_sdm632-common common-tree
git clone https://github.com/vulkan-ops/vendor_motorola_ocean   vendor-ocean
git clone https://github.com/vulkan-ops/vendor_motorola_channel   vendor-channel
git clone https://github.com/vulkan-ops/vendor_motorola_river   vendor-river
git clone https://github.com/vulkan-ops/vendor_motorola_sdm632-common  vendor-common
git clone https://github.com/vulkan-ops/kernel_motorola_sdm632   kernel
git clone https://github.com/vulkan-ops/arch arch-script
}

function b () {
. build/envsetup.sh
#make installclean
lunch lineage_${1}-userdebug
make  bacon -j$(nproc --all) | tee ${1}.log
#make otapackage  | tee ${1}.log
}

function v () {
. build/envsetup.sh
#export TEMPORARY_DISABLE_PATH_RESTRICTIONS=true
#export SKIP_ABI_CHECKS=true
#make installclean
lunch derp_${1}-eng
#make otapackage  | tee ${1}.log
mka derp -j$(nproc --all) | tee ${1}.log
}

