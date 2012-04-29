#!/bin/sh

# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DEVICE=galaxys4g

rm -rf ../../../vendor/samsung/$DEVICE/*
mkdir -p ../../../vendor/samsung/$DEVICE/proprietary

if [ -f "$1" ]; then
	rm -rf tmp
	mkdir tmp
	unzip -q "$1" -d tmp
	if [ $? != 0 ]; then
		echo "$1 is not a valid zip file. Bye."
		exit 1
	fi
	echo "$1 successfully unzip'd. Copying files..."
	ZIP="true"
else
	unset ZIP
fi

DIRS="
vendor/bin
bin
cameradata
etc/wifi
lib/egl
lib/hw
media
"

for DIR in $DIRS; do
	mkdir -p ../../../vendor/samsung/$DEVICE/proprietary/$DIR
done

FILES="
bin/BCM4329B1_002.002.023.0746.0832.hcd

etc/wifi/nvram_net.txt
etc/wifi/nvram_mfg.txt
etc/wifi/bcm4329_aps.bin
etc/wifi/bcm4329_mfg.bin
etc/wifi/bcm4329_sta.bin

bin/tvoutserver
cameradata/datapattern_420sp.yuv
cameradata/datapattern_front_420sp.yuv
lib/libActionShot.so
lib/libcamera.so
lib/libarccamera.so
lib/libcamera_client.so
lib/libcamerafirmwarejni.so
lib/libcameraservice.so
lib/libCamera_gingerbread.so
lib/libCaMotion.so
lib/libcaps.so
lib/libPanoraMax1.so
lib/libPlusMe.so
lib/libs3cjpeg.so
lib/libseccamera.so
lib/libseccameraadaptor.so
lib/libsecjpegencoder.so
lib/libtvout.so
lib/lib_tvoutengine.so
lib/libtvoutfimc.so
lib/libtvouthdmi.so
lib/libtvoutservice.so

bin/pppd
bin/rild
lib/libril.so
lib/libsec-ril.so
lib/libsecril-client.so

etc/gps.conf
vendor/bin/gpsd
lib/hw/gps.s5pc110.so

bin/pvrsrvinit
lib/egl/libEGL_POWERVR_SGX540_120.so
lib/egl/libGLES_android.so
lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so
lib/egl/libGLESv2_POWERVR_SGX540_120.so
lib/libsrv_um.so
lib/libsrv_init.so
lib/libIMGegl.so
lib/libpvr2d.so
lib/libpvrANDROID_WSEGL.so
lib/libglslcompiler.so
lib/libPVRScopeServices.so
lib/libusc.so

bin/geomagneticd
bin/orientationd
lib/libsensorservice.so
lib/libsensor_yamaha_test.so
lib/hw/sensors.default.so

lib/hw/copybit.s5pc110.so
lib/hw/lights.s5pc110.so
lib/hw/gralloc.s5pc110.so
lib/hw/overlay.s5pc110.so

bin/playlpm
bin/charging_mode
lib/libQmageDecoder.so
media/battery_charging_5.qmg
media/battery_charging_10.qmg
media/battery_charging_15.qmg
media/battery_charging_20.qmg
media/battery_charging_25.qmg
media/battery_charging_30.qmg
media/battery_charging_35.qmg
media/battery_charging_40.qmg
media/battery_charging_45.qmg
media/battery_charging_50.qmg
media/battery_charging_55.qmg
media/battery_charging_60.qmg
media/battery_charging_65.qmg
media/battery_charging_70.qmg
media/battery_charging_75.qmg
media/battery_charging_80.qmg
media/battery_charging_85.qmg
media/battery_charging_90.qmg
media/battery_charging_95.qmg
media/battery_charging_100.qmg
media/chargingwarning.qmg
media/Disconnected.qmg
"

for FILE in $FILES; do
	if [ "$ZIP" ]; then
		cp tmp/system/"$FILE" ../../../vendor/samsung/$DEVICE/proprietary/$FILE
	else
		adb pull system/$FILE ../../../vendor/samsung/$DEVICE/proprietary/$FILE
	fi
done
if [ "$ZIP" ]; then rm -rf tmp ; fi

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g > ../../../vendor/samsung/$DEVICE/$DEVICE-vendor-blobs.mk
# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/samsung/__DEVICE__/extract-files.sh

#
# prelink
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcamera.so:obj/lib/libcamera.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecril-client.so:obj/lib/libsecrilclient.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsec-ril.so:obj/lib/libsec-ril.so

#
# Wifi
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/nvram_net.txt:system/etc/wifi/nvram_net.txt \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/nvram_mfg.txt:system/etc/wifi/nvram_mfg.txt \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/bcm4329_aps.bin:system/etc/wifi/bcm4329_aps.bin \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/bcm4329_mfg.bin:system/etc/wifi/bcm4329_mfg.bin \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/bcm4329_sta.bin:system/etc/wifi/bcm4329_sta.bin

#
# Display (3D)
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/pvrsrvinit:system/bin/pvrsrvinit \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libEGL_POWERVR_SGX540_120.so:system/lib/egl/libEGL_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libGLES_android.so:system/lib/egl/libGLES_android.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so:system/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libGLESv2_POWERVR_SGX540_120.so:system/lib/egl/libGLESv2_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsrv_um.so:system/lib/libsrv_um.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsrv_init.so:system/lib/libsrv_init.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libIMGegl.so:system/lib/libIMGegl.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libpvr2d.so:system/lib/libpvr2d.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libpvrANDROID_WSEGL.so:system/lib/libpvrANDROID_WSEGL.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libglslcompiler.so:system/lib/libglslcompiler.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libPVRScopeServices.so:system/lib/libPVRScopeServices.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libusc.so:system/lib/libusc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/gralloc.s5pc110.so:system/lib/hw/gralloc.s5pc110.so

#
# Sensors, Lights etc
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/geomagneticd:system/bin/geomagneticd \\
    vendor/samsung/__DEVICE__/proprietary/bin/orientationd:system/bin/orientationd \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/sensors.default.so:system/lib/hw/sensors.default.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsensor_yamaha_test.so:system/lib/libsensor_yamaha_test.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsensorservice.so:system/lib/libsensorservice.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/copybit.s5pc110.so:system/lib/hw/copybit.s5pc110.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/lights.s5pc110.so:system/lib/hw/lights.s5pc110.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/overlay.s5pc110.so:system/lib/hw/overlay.s5pc110.so

#
# Bluetooth
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/BCM4329B1_002.002.023.0746.0832.hcd:system/bin/BCM4329B1_002.002.023.0746.0832.hcd

#
# Camera
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/tvoutserver:system/bin/tvoutserver \\
    vendor/samsung/__DEVICE__/proprietary/cameradata/datapattern_420sp.yuv:system/cameradata/datapattern_420sp.yuv \\
    vendor/samsung/__DEVICE__/proprietary/cameradata/datapattern_front_420sp.yuv:system/cameradata/datapattern_front_420sp.yuv \\
    vendor/samsung/__DEVICE__/proprietary/lib/libActionShot.so:system/lib/libActionShot.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcamera.so:system/lib/libcamera.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libarccamera.so:system/lib/libarccamera.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcamera_client.so:system/lib/libcamera_client.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcamerafirmwarejni.so:system/lib/libcamerafirmwarejni.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcameraservice.so:system/lib/libcameraservice.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libCamera_gingerbread.so:system/lib/libCamera_gingerbread.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libCaMotion.so:system/lib/libCaMotion.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcaps.so:system/lib/libcaps.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libPanoraMax1.so:system/lib/libPanoraMax1.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libPlusMe.so:system/lib/libPlusMe.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libs3cjpeg.so:system/lib/libs3cjpeg.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libseccamera.so:system/lib/libseccamera.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libseccameraadaptor.so:system/lib/libseccameraadaptor.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecjpegencoder.so:system/lib/libsecjpegencoder.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libtvout.so:system/lib/libtvout.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/lib_tvoutengine.so:system/lib/lib_tvoutengine.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libtvoutfimc.so:system/lib/libtvoutfimc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libtvouthdmi.so:system/lib/libtvouthdmi.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libtvoutservice.so:system/lib/libtvoutservice.so

#
# RIL
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/pppd:system/bin/pppd \\
    vendor/samsung/__DEVICE__/proprietary/bin/rild:system/bin/rild \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsec-ril.so:system/lib/libsec-ril.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecril-client.so:system/lib/libsecril-client.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libril.so:system/lib/libril.so

#
# GPS
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/vendor/bin/gpsd:system/vendor/bin/gpsd \\
    vendor/samsung/__DEVICE__/proprietary/etc/gps.conf:system/etc/gps.conf \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/gps.s5pc110.so:system/lib/hw/gps.s5pc110.so

#
# Files for battery charging screen
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/playlpm:system/bin/playlpm \\
    vendor/samsung/__DEVICE__/proprietary/bin/charging_mode:system/bin/charging_mode \\
    vendor/samsung/__DEVICE__/proprietary/lib/libQmageDecoder.so:system/lib/libQmageDecoder.so \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_5.qmg:system/media/battery_charging_5.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_10.qmg:system/media/battery_charging_10.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_15.qmg:system/media/battery_charging_15.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_20.qmg:system/media/battery_charging_20.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_25.qmg:system/media/battery_charging_25.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_30.qmg:system/media/battery_charging_30.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_35.qmg:system/media/battery_charging_35.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_40.qmg:system/media/battery_charging_40.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_45.qmg:system/media/battery_charging_45.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_50.qmg:system/media/battery_charging_50.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_55.qmg:system/media/battery_charging_55.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_60.qmg:system/media/battery_charging_60.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_65.qmg:system/media/battery_charging_65.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_70.qmg:system/media/battery_charging_70.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_75.qmg:system/media/battery_charging_75.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_80.qmg:system/media/battery_charging_80.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_85.qmg:system/media/battery_charging_85.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_90.qmg:system/media/battery_charging_90.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_95.qmg:system/media/battery_charging_95.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_100.qmg:system/media/battery_charging_100.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/chargingwarning.qmg:system/media/chargingwarning.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/Disconnected.qmg:system/media/Disconnected.qmg

EOF

adb pull /system/lib/libaudio.so ../../../../vendor/samsung/galaxys4g/proprietary/lib/libaudio.so
adb pull /system/lib/libaudio.so out/target/product/galaxys4g/obj/lib/libaudio.so
mkdir out/target/product/galaxys4g/system/lib/
adb pull /system/lib/libaudio.so out/target/product/galaxys4g/system/lib/libaudio.so

adb pull /system/lib/libaudiopolicy.so proprietary/libaudiopolicy.so
adb pull /system/lib/libaudiopolicy.so out/target/product/galaxys4g/obj/lib/libaudiopolicy.so

./setup-makefiles.sh
