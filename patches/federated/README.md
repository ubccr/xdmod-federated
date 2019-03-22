When running a federation HUB you will need the following changes made to the OpenXDMoD code.
**NOTE** This is done automatically as part of `xdmod-setup` when setting the federation type to `hub`

patch -up1 --directory=/usr/share/xdmod/ < patches/cloud/usr-share-xdmod.diff
patch -up2 --directory=/etc/xdmod/ < patches/cloud/configuration.diff

If you have no jobs data use the following as well to remove Jobs related information.

patch -up1 --directory=/usr/share/xdmod/ < patches/cloud/nojobs-usr-share-xdmod.diff
patch -up2 --directory=/etc/xdmod/ < patches/cloud/nojobs-configuration.diff
