# DDE-metadata
Work on Geonetwork catalog implementation for DDE. Use ISO19115-3 as base, with xslt for DDE schema in and out

## Note on the missing release binary

This repository was hosted on `opencode.deep-time.org`. That GitLab instance is offline, and the
repository was mirrored to https://github.com/usgin/dde-metadata on 2026-08-26.

One file did not survive the move. On the `geonetwork` branch,
`GeoNetworkRelease/geonetwork.war` is a git-LFS pointer, and its LFS object was stored on the
retired GitLab server. The pointer is now dangling and the binary is unrecoverable.

The `.war` was a build artifact, so an equivalent can be rebuilt from source
(`mvn clean install -DskipTests` against the `DDEcore-geonetwork` submodule, mirrored at
https://github.com/usgin/DDEcore-geonetwork). The **exact** 2024 release binary is gone and cannot
be reproduced byte-for-byte — dependency resolution, plugin versions, and build timestamps have all
moved on since.
