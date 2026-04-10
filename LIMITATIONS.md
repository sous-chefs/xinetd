# Limitations

## Supported Platforms (verified via endoflife.date)

| Platform      | Versions          | EOL        |
|---------------|-------------------|------------|
| AlmaLinux     | 8                 | 2029-03-01 |
| AlmaLinux     | 9                 | 2032-05-31 |
| AlmaLinux     | 10                | 2035-05-31 |
| Debian        | 12 (bookworm)     | 2026-06-10 |
| Debian        | 13 (trixie)       | 2028-08-09 |
| openSUSE Leap | 15 (latest: 15.6) | 2026-04-30 |
| Oracle Linux  | 8                 | 2029-07-31 |
| Oracle Linux  | 9                 | 2032-06-30 |
| Rocky Linux   | 8                 | 2029-05-31 |
| Rocky Linux   | 9                 | 2032-05-31 |
| Rocky Linux   | 10                | 2035-05-31 |
| Ubuntu        | 22.04 LTS         | 2027-04-01 |
| Ubuntu        | 24.04 LTS         | 2029-05-31 |

## Package Availability

### APT (Debian/Ubuntu)

- Ubuntu 22.04+: xinetd 2.3.15.4 (amd64, arm64)
- Debian 12 (bookworm): xinetd 2.3.15.3
- Debian 13 (trixie): xinetd 2.3.15.4

### DNF/YUM (RHEL family)

- AlmaLinux 8/9/10, Rocky Linux 8/9/10, Oracle Linux 8/9: xinetd available in base or EPEL repos
- CentOS Stream, Fedora, Amazon Linux 2023: **NOT AVAILABLE** — not tested or supported

### Zypper (SUSE)

- openSUSE Leap 15.6: xinetd 2.3.15.4 (amd64)

## Architecture Limitations

- Package available for amd64 on all supported platforms
- arm64 available on Ubuntu 22.04+ and Debian 12/13

## Known Issues

- xinetd is considered **legacy** software. The upstream recommendation for modern systems
  is to use systemd socket activation instead.
- No security updates have been released to the xinetd upstream since 2.3.15.4 (2019).
  Deployments should be considered carefully in security-sensitive environments.
