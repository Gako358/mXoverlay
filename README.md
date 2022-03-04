# mXOverlay

[![Build Status](https://travis-ci.org/storax/storax-overlay.png)](https://travis-ci.org/storax/storax-overlay)

Overlay for projects not officially supported that I personally would like to manage with
portage.

> **These ebuilds are "maintained" by myself. Feel free to provide feedback or contribute but please be aware that I only have limited time to dedicade towards this overlay.

This overlay is only tested on **amd64 (64bit)**.

## Installation

Prerequisite for managing overlays is [_layman_](http://layman.sourceforge.net).
Install **app-portage/layman** with:

```
emerge -av app-portage/layman
```

Download the overlay metadata into the _layman_ overlays directory:

```
wget -q -O /etc/layman/overlays/mXoverlay.xml https://raw.githubusercontent.com/gako358/mXoverlay/main/overlay.xml
```

Fetch all available overlays and add **mXoverlay**:

```
layman -Lk
layman -a mXoverlay
```

## Updates

Sync updates with:

```
layman -s mXoverlay
```


## Uninstall

To remove this overlay remove it from the active overlays first and then remove the metadata file:

```
layman -d mXoverlay
rm -r /etc/layman/overlays/mXoverlay.xml
```
