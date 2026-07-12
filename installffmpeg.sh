sudo dnf clean all
sudo dnf makecache

# 2️⃣ Remove any partially installed conflicting packages
sudo dnf remove gstreamer1-plugin-libav libavfilter-free rubberband ffmpeg ffmpeg-libs -y

# 3️⃣ Install a minimal working GStreamer + FFmpeg stack
sudo dnf install \
gstreamer1-plugins-base \
gstreamer1-plugins-good \
gstreamer1-plugins-bad-free \
gstreamer1-plugins-ugly \
ffmpeg \
--nobest --skip-broken \
--disablerepo=epel* \
--enablerepo=rpmfusion-free-updates,rpmfusion-nonfree-updates

