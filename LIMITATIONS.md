# Limitations

## Supported Platforms (verified via endoflife.date)

| Platform      | Versions          | EOL        | xinetd available |
|---------------|-------------------|------------|------------------|
| AlmaLinux     | 8                 | 2029-03-01 | Yes              |
| Debian        | 12 (bookworm)     | 2026-06-10 | Yes              |
| openSUSE Leap | 15 (latest: 15.6) | 2026-04-30 | Yes              |
| Oracle Linux  | 8                 | 2029-07-31 | Yes              |
| Rocky Linux   | 8                 | 2029-05-31 | Yes              |
| Ubuntu        | 22.04 LTS         | 2027-04-01 | Yes              |
| Ubuntu        | 24.04 LTS         | 2029-05-31 | Yes              |

## Platforms Without xinetd Package

The xinetd package has been removed from RHEL 9 and all its derivatives.
These platforms are **NOT supported** because the package is unavailable
in their default or EPEL repositories:

| Platform      | Versions | Reason                             |
|---------------|----------|------------------------------------|
| AlmaLinux     | 9, 10    | xinetd removed from EL9+ AppStream |
| Oracle Linux  | 9        | xinetd removed from EL9+ AppStream |
| Rocky Linux   | 9, 10    | xinetd removed from EL9+ AppStream |
| CentOS Stream | 9, 10    | xinetd removed from EL9+ AppStream |
| Fedora        | all      | xinetd not shipped                 |
| Amazon Linux  | 2023     | xinetd not shipped                 |

The recommended replacement on EL9+ is **systemd socket activation**.

## Package Availability

### APT (Debian/Ubuntu)

- Ubuntu 22.04+: xinetd 2.3.15.4 (amd64, arm64)
- Debian 12 (bookworm): xinetd 2.3.15.3

### DNF/YUM (RHEL family)

- AlmaLinux 8, Oracle Linux 8, Rocky Linux 8: xinetd 2:2.3.15 in AppStream
- EL9+ (AlmaLinux 9/10, Oracle Linux 9, Rocky Linux 9/10): **NOT AVAILABLE**

### Zypper (SUSE)

- openSUSE Leap 15.6: xinetd 2.3.15.4 (amd64)

## Architecture Limitations

- Package available for amd64 on all supported platforms
- arm64 available on Ubuntu 22.04+ and Debian 12

## Known Issues

- xinetd is considered **legacy** software. The upstream recommendation for modern systems
  is to use systemd socket activation instead.
- No security updates have been released to the xinetd upstream since 2.3.15.4 (2019).
  Deployments should be considered carefully in security-sensitive environments.
- Ubuntu 24.04: the `xinetd` service may fail to start when multiple INTERNAL
  (builtin) services are enabled simultaneously due to socket conflicts.
