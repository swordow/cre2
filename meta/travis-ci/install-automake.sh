#!/bin/bash
#
# Installation  script  to  run  from  the  Travis  config  file  before
# attempting a build.
#
# Install Automake 1.15 under the  directory "/tmp/mine".  We assume the
# script is run from the top directory of the build tree.

PROGNAME=install-automake.sh
STEM=automake-1.15
ARCHIVE="${STEM}.tar.gz"
SOURCE_URI="http://ftp.gnu.org/gnu/automake/${ARCHIVE}"
LOCAL_ARCHIVE="/tmp/${ARCHIVE}"
TOP_SRCDIR="/tmp/${STEM}"

test -d /tmp/mine || mkdir --mode=0755 /tmp/mine

if ! wget "$SOURCE_URI" -O "$LOCAL_ARCHIVE"
then
    printf '%s: error downloading %s\n' "$PROGNAME" "${ARCHIVE}" >&2
    exit 1
fi

cd /tmp

if ! tar -xzf "$LOCAL_ARCHIVE"
then
    printf '%s: error unpacking %s\n' "$PROGNAME" "$LOCAL_ARCHIVE" >&2
    exit 1
fi

cd "$TOP_SRCDIR"

if ! ./configure --prefix=/tmp/mine
then
    printf '%s: error configuring %s\n' "$PROGNAME" "${STEM}" >&2
    exit 1
fi

if ! make
then
    printf '%s: error configuring %s\n' "$PROGNAME" "${STEM}" >&2
    exit 1
fi

if ! make install
then
    printf '%s: error configuring %s\n' "$PROGNAME" "${STEM}" >&2
    exit 1
fi

exit 0

# Local Variables:
# mode: sh
# End:
