# AGENTS.md

## Cookbook Purpose

This cookbook manages the xinetd extended internet services daemon through custom resources:
`xinetd_install`, `xinetd_config`, `xinetd_service`, and `xinetd_builtin_services`.

## Agent Findings

* Full migration scope means this cookbook has no root `recipes/` or `attributes/` directories.
  Public usage should go through custom resources and test cookbook recipes.
* `xinetd` is legacy software. On newer systems, especially EL9+, Fedora, and Amazon Linux 2023,
  systemd socket activation is the practical replacement.
* Do not add systemd unit management to the resources without a concrete need. The distro package
  ships the `xinetd` service unit, and the cookbook manages that packaged service.
* openSUSE Leap support is intentionally removed. Leap 15.6 reached EOL on 2026-04-30, and
  software.opensuse.org does not list an official Leap 16.0 `xinetd` package.
* Debian 12 remains supported as of 2026-06-29; Debian security support ends on 2026-07-11 and
  Debian LTS continues until 2028-06-30. Debian 13 is the forward supported Debian target and has
  an official `xinetd` package.

## Package Availability

### APT (Debian/Ubuntu)

* Debian 12 bookworm: `xinetd` 1:2.3.15.3-1+b1 for amd64, arm64, armel, armhf, i386, mips64el,
  mipsel, ppc64el, and s390x.
* Debian 13 trixie: `xinetd` 1:2.3.15.4-5 for amd64, arm64, armel, armhf, i386, ppc64el,
  riscv64, and s390x.
* Ubuntu 22.04 Jammy: `xinetd` 1:2.3.15.3-1.
* Ubuntu 24.04 Noble: `xinetd` 1:2.3.15.4-3build1.
* Ubuntu 25.04 Plucky, 25.10 Questing, and 26.04 Resolute publish newer 1:2.3.15.4 builds, but
  Kitchen and CI coverage is limited to current LTS targets until the Dokken image matrix is
  explicitly expanded.

### DNF/YUM (RHEL family)

* AlmaLinux 8, Oracle Linux 8, and Rocky Linux 8 ship `xinetd` 2:2.3.15 in AppStream-compatible
  repositories.
* EL9+ derivatives are not supported because `xinetd` is not available in default AppStream/EPEL
  repositories.
* Unsupported package targets from the previous limitations file remain unsupported:
  AlmaLinux 9/10, Oracle Linux 9, Rocky Linux 9/10, CentOS Stream 9/10, all Fedora releases, and
  Amazon Linux 2023.

### Zypper (SUSE)

* No supported openSUSE Leap target is covered. Leap 15 is EOL, and Leap 16.0 has no official
  `xinetd` package.

## Architecture Limitations

* Debian and Ubuntu publish `xinetd` for amd64 and arm64 on supported releases.
* EL8 support is validated for the standard x86_64 package path used by the Sous-Chefs Kitchen
  matrix.

## Source/Compiled Installation

This cookbook does not build xinetd from source. It installs the distro package and manages packaged
configuration and service files.

## Known Issues

* xinetd has not seen meaningful upstream security-release activity since the 2.3.15.4 line.
  Review deployments carefully in security-sensitive environments.
* Ubuntu 24.04: the `xinetd` service may fail to start when multiple INTERNAL builtin services are
  enabled simultaneously due to socket conflicts. The `builtin-services` suite intentionally keeps
  that behavior visible in Kitchen and CI rather than silently skipping the platform.

## Test and CI Notes

* Dokken is the default CI driver because the cookbook manages Linux packages, configuration files,
  and the packaged xinetd service.
* The default Kitchen suite must remain `default`, use `recipe[test::default]`, and verify
  `test/integration/default/`.
* Keep platform lists synchronized across `kitchen.yml`, `kitchen.dokken.yml`,
  `kitchen.global.yml`, and the `.github/workflows/ci.yml` integration matrix.
* `kitchen.exec.yml` is not part of the Linux package test matrix and should not drive platform
  support decisions unless the CI strategy explicitly changes.
