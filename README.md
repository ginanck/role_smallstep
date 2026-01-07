<!-- DOCSIBLE START -->
# Ansible Role: role_smallstep


role_smallstep to configure base settings


## Table of Contents

- [Requirements](#requirements)
- [Dependencies](#dependencies)
- [Role Variables](#role-variables)
- [Task Overview](#task-overview)
- [Example Playbook](#example-playbook)
- [Documentation Maintenance](#documentation-maintenance)
- [License](#license)
- [Author Information](#author-information)

## Requirements



- Ansible >= 2.9


- Supported platforms:
  - Ubuntu (jammy, noble)
  - Debian (bullseye, bookworm)
  - AlmaLinux (9, 10)
  - RockyLinux (9.0, 10)



## Dependencies


This role requires the following roles and collections:




  
    
  

  
    
  

  
    
  

  
    
  



**Roles:**

- [role_base](https://github.com/ginanck/role_base.git) (version: master)




**Collections:**

- `community.docker` (>= 4.8.1)

- `community.general` (>= 6.6.1)

- `ansible.posix` (>= 1.5.4)



To install all dependencies:
```bash
ansible-galaxy install -r meta/install_requirements.yml
```


## Role Variables



### File: `defaults/main.yml`

| Variable | Type | Default Value | Description |
|----------|------|---------------|-------------|
| [`smallstep_ca_name`](defaults/main.yml#L10) | str | `Internal Root CA Certificate` | None |
| [`smallstep_ca_dns`](defaults/main.yml#L11) | str | `ca.internal.guru` | None |
| [`smallstep_ca_port`](defaults/main.yml#L12) | str | `4443` | None |
| [`smallstep_ca_provisioner`](defaults/main.yml#L13) | str | `admin` | None |
| [`smallstep_ca_server_url`](defaults/main.yml#L14) | str | `https://{{ smallstep_ca_dns }}:{{ smallstep_ca_port }}` | None |
| [`smallstep_ca_scripts_url`](defaults/main.yml#L15) | str | `http://{{ smallstep_ca_dns }}/scripts` | None |
| [`smallstep_ca_validity`](defaults/main.yml#L17) | str | `87660h` | None |
| [`smallstep_intermediate_ca_validity`](defaults/main.yml#L18) | str | `87660h` | None |
| [`smallstep_enable_auto_renewal`](defaults/main.yml#L20) | bool | `False` | None |
| [`smallstep_renewal_threshold`](defaults/main.yml#L21) | int | `30` | None |
| [`smallstep_cleanup_old_backups`](defaults/main.yml#L22) | bool | `True` | None |
| [`smallstep_max_tls_cert_duration`](defaults/main.yml#L24) | str | `87660h` | None |
| [`smallstep_default_tls_cert_duration`](defaults/main.yml#L25) | str | `4380h` | None |
| [`smallstep_certificates`](defaults/main.yml#L27) | list | `[]` | None |
| [`smallstep_base_url`](defaults/main.yml#L68) | str | `https://github.com/smallstep` | None |
| [`smallstep_bin_dir`](defaults/main.yml#L69) | str | `/opt/smallstep` | None |
| [`smallstep_link_path`](defaults/main.yml#L70) | str | `/usr/local/bin` | None |
| [`smallstep_www_dir`](defaults/main.yml#L72) | str | `{{ smallstep_bin_dir }}/www` | None |
| [`smallstep_www_certs_dir`](defaults/main.yml#L73) | str | `{{ smallstep_www_dir }}/certs` | None |
| [`smallstep_www_scripts_dir`](defaults/main.yml#L74) | str | `{{ smallstep_www_dir }}/scripts` | None |
| [`smallstep_log_dir`](defaults/main.yml#L75) | str | `/var/log/smallstep` | None |
| [`smallstep_ca_version`](defaults/main.yml#L77) | str | `0.28.3` | None |
| [`smallstep_ca_archive`](defaults/main.yml#L78) | str | `step-ca_linux_{{ smallstep_ca_version }}_amd64.tar.gz` | None |
| [`smallstep_ca_url`](defaults/main.yml#L79) | str | `{{ smallstep_base_url }}/certificates/releases/download/v{{ smallstep_ca_version }}/{{ smallstep_ca_archive }}` | None |
| [`smallstep_cli_version`](defaults/main.yml#L82) | str | `0.28.6` | None |
| [`smallstep_cli_archive`](defaults/main.yml#L83) | str | `step_linux_{{ smallstep_cli_version }}_amd64.tar.gz` | None |
| [`smallstep_cli_url`](defaults/main.yml#L84) | str | `{{ smallstep_base_url }}/cli/releases/download/v{{ smallstep_cli_version }}/{{ smallstep_cli_archive }}` | None |




## Task Overview


This role performs the following tasks:


### File: `tasks/renew_certs.yml`

| Task Name | Module | Has Conditions | Line |
|-----------|--------|----------------|------|
| [Check certificate expiration status](tasks/renew_certs.yml#L) | ansible.builtin.command | No | N/A |
| [Parse certificate expiration dates](tasks/renew_certs.yml#L) | ansible.builtin.set_fact | Yes | N/A |
| [Display certificates needing renewal](tasks/renew_certs.yml#L) | ansible.builtin.debug | No | N/A |
| [Create backup directory for old certificates](tasks/renew_certs.yml#L) | ansible.builtin.file | Yes | N/A |
| [Move existing certificates to backup directory](tasks/renew_certs.yml#L) | ansible.builtin.copy | Yes | N/A |
| [Move existing private keys to backup directory](tasks/renew_certs.yml#L) | ansible.builtin.copy | Yes | N/A |
| [Move existing fullchain certificates to backup directory](tasks/renew_certs.yml#L) | ansible.builtin.copy | Yes | N/A |
| [Get CA root certificate fingerprint](tasks/renew_certs.yml#L) | ansible.builtin.command | Yes | N/A |
| [Set CA fingerprint fact](tasks/renew_certs.yml#L) | ansible.builtin.set_fact | Yes | N/A |
| [Renew certificates using step ca renew command](tasks/renew_certs.yml#L) | ansible.builtin.command | Yes | N/A |
| [Generate new certificates if renewal fails (fallback)](tasks/renew_certs.yml#L) | ansible.builtin.command | Yes | N/A |
| [Recreate fullchain certificates with intermediate for renewed certs](tasks/renew_certs.yml#L) | ansible.builtin.shell | Yes | N/A |
| [Verify renewed certificates](tasks/renew_certs.yml#L) | ansible.builtin.command | Yes | N/A |
| [Get renewed certificate information](tasks/renew_certs.yml#L) | ansible.builtin.command | Yes | N/A |
| [Update certificate info file for renewed certificates](tasks/renew_certs.yml#L) | ansible.builtin.template | Yes | N/A |
| [Log renewal completion with backup location](tasks/renew_certs.yml#L) | ansible.builtin.debug | Yes | N/A |
| [Trigger service restarts for renewed certificates](tasks/renew_certs.yml#L) | ansible.builtin.debug | Yes | N/A |
| [Clean up old certificate backup directories (keep last 5)](tasks/renew_certs.yml#L) | ansible.builtin.shell | Yes | N/A |




### File: `tasks/issue_certs.yml`

| Task Name | Module | Has Conditions | Line |
|-----------|--------|----------------|------|
| [Create certificate directories](tasks/issue_certs.yml#L) | ansible.builtin.file | No | N/A |
| [Get CA fingerprint](tasks/issue_certs.yml#L) | ansible.builtin.command | No | N/A |
| [Set CA fingerprint fact](tasks/issue_certs.yml#L) | ansible.builtin.set_fact | No | N/A |
| [Check if bootstrap already exists](tasks/issue_certs.yml#L) | ansible.builtin.stat | No | N/A |
| [Bootstrap step client with CA fingerprint](tasks/issue_certs.yml#L) | ansible.builtin.command | Yes | N/A |
| [Issue certificates using step ca certificate command](tasks/issue_certs.yml#L) | ansible.builtin.command | No | N/A |
| [Create fullchain certificates (with intermediate)](tasks/issue_certs.yml#L) | ansible.builtin.shell | No | N/A |
| [Verify issued certificates](tasks/issue_certs.yml#L) | ansible.builtin.command | No | N/A |
| [Get certificate information](tasks/issue_certs.yml#L) | ansible.builtin.command | No | N/A |
| [Create certificate info file](tasks/issue_certs.yml#L) | ansible.builtin.template | No | N/A |




### File: `tasks/generate_scripts.yml`

| Task Name | Module | Has Conditions | Line |
|-----------|--------|----------------|------|
| [Generate install-linux.sh script](tasks/generate_scripts.yml#L) | ansible.builtin.template | No | N/A |
| [Generate install-linux.sh script](tasks/generate_scripts.yml#L) | ansible.builtin.template | No | N/A |
| [Generate install-windows.ps1](tasks/generate_scripts.yml#L) | ansible.builtin.template | No | N/A |
| [Generate README.md](tasks/generate_scripts.yml#L) | ansible.builtin.template | No | N/A |




### File: `tasks/init.yml`

| Task Name | Module | Has Conditions | Line |
|-----------|--------|----------------|------|
| [Update password file for ca-server](tasks/init.yml#L) | ansible.builtin.template | No | N/A |
| [CA Server Start Script](tasks/init.yml#L) | ansible.builtin.template | No | N/A |
| [Create CA directories](tasks/init.yml#L) | ansible.builtin.file | No | N/A |
| [Generate root CA certificate and key](tasks/init.yml#L) | ansible.builtin.command | No | N/A |
| [Generate intermediate CA certificate and key](tasks/init.yml#L) | ansible.builtin.command | No | N/A |
| [Generate provisioner JWK key pair](tasks/init.yml#L) | ansible.builtin.command | No | N/A |
| [Get root certificate fingerprint](tasks/init.yml#L) | ansible.builtin.command | No | N/A |
| [Read provisioner public key](tasks/init.yml#L) | ansible.builtin.slurp | No | N/A |
| [Read provisioner encrypted private key](tasks/init.yml#L) | ansible.builtin.slurp | No | N/A |
| [Set facts for JSON construction](tasks/init.yml#L) | ansible.builtin.set_fact | No | N/A |
| [Generate ca.json configuration](tasks/init.yml#L) | ansible.builtin.template | No | N/A |
| [Generate defaults.json configuration](tasks/init.yml#L) | ansible.builtin.template | No | N/A |
| [Create systemd file for smallstep](tasks/init.yml#L) | ansible.builtin.template | No | N/A |
| [Start and enable smallstep service](tasks/init.yml#L) | ansible.builtin.systemd | No | N/A |




### File: `tasks/install.yml`

| Task Name | Module | Has Conditions | Line |
|-----------|--------|----------------|------|
| [Create smallstep ca-server dir](tasks/install.yml#L) | ansible.builtin.file | No | N/A |
| [Download step-ca binary](tasks/install.yml#L) | ansible.builtin.get_url | No | N/A |
| [Unarchive step-ca Server](tasks/install.yml#L) | ansible.builtin.unarchive | No | N/A |
| [Unarchive step-cli binary](tasks/install.yml#L) | ansible.builtin.unarchive | No | N/A |
| [Copy binary files](tasks/install.yml#L) | ansible.builtin.copy | No | N/A |
| [Set up alternatives for smallstep](tasks/install.yml#L) | community.general.alternatives | No | N/A |




### File: `tasks/main.yml`

| Task Name | Module | Has Conditions | Line |
|-----------|--------|----------------|------|
| [Install smallstep ca-server](tasks/main.yml#L) | ansible.builtin.include_tasks | No | N/A |
| [Initialize smallstep ca-server](tasks/main.yml#L) | ansible.builtin.include_tasks | No | N/A |
| [Generate certificates](tasks/main.yml#L) | ansible.builtin.include_tasks | No | N/A |
| [Issue certificates](tasks/main.yml#L) | ansible.builtin.include_tasks | Yes | N/A |
| [Renew certificates](tasks/main.yml#L) | ansible.builtin.include_tasks | Yes | N/A |






## Example Playbook

```yaml
---
- hosts: all
  become: yes
  roles:
    - role: role_smallstep

      vars:
        smallstep_ca_name: Internal Root CA Certificate
        smallstep_ca_dns: ca.internal.guru
        smallstep_ca_port: 4443

```

## Documentation Maintenance

### Updating Dependencies

1. **Update** `meta/main.yml`:
   ```yaml
   documented_requirements:
     - src: https://github.com/user/role.git
       version: master
     - name: collection.name
       version: 1.0.0
   ```

2. **Sync** `meta/install_requirements.yml` with the same requirements

3. **Regenerate** documentation:
   ```bash
   pre-commit run --all-files
   ```

### Template Updates

- Edit `.docsible_template.md` for structure changes
- Test with: `docsible --role . --md-template .docsible_template.md -nob -com -tl`
- Commit both template and generated README.md

### Quick Checklist

When updating dependencies:
- [ ] Add to `meta/main.yml` → `documented_requirements`
- [ ] Add to `meta/install_requirements.yml`
- [ ] Run `pre-commit run --all-files`
- [ ] Verify generated README.md
- [ ] Commit all changes

## License


license (GPL-2.0-or-later, MIT, etc)


## Author Information


**Author:** gkorkmaz




**GitHub:** [gkorkmaz](https://github.com/gkorkmaz)

---
*This documentation was automatically generated using [docsible](https://github.com/zbohm/docsible).*
<!-- DOCSIBLE END -->
