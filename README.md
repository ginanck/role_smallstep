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

**These are static variables with lower priority**



#### File: defaults/main.yml

| Var | Type | Value |
|-----|------|-------|
| [smallstep_acme_enabled](defaults/main.yml#L26) | bool | `True` |
| [smallstep_acme_provisioner_name](defaults/main.yml#L27) | str | `acme` |
| [smallstep_acme_require_eab](defaults/main.yml#L28) | bool |  |
| [smallstep_backup_dir](defaults/main.yml#L97) | str | `{{ smallstep_bin_dir }}/backup` |
| [smallstep_backup_enabled](defaults/main.yml#L96) | bool | `True` |
| [smallstep_backup_retention](defaults/main.yml#L98) | int | `7` |
| [smallstep_base_url](defaults/main.yml#L78) | str | `https://github.com/smallstep` |
| [smallstep_bin_dir](defaults/main.yml#L79) | str | `/opt/smallstep` |
| [smallstep_ca_archive](defaults/main.yml#L103) | str | `step-ca_linux_{{ smallstep_ca_version }}_amd64.tar.gz` |
| [smallstep_ca_certs_dir](defaults/main.yml#L84) | str | `{{ smallstep_ca_dir }}/certs` |
| [smallstep_ca_config_dir](defaults/main.yml#L83) | str | `{{ smallstep_ca_dir }}/config` |
| [smallstep_ca_db_dir](defaults/main.yml#L86) | str | `{{ smallstep_ca_dir }}/db` |
| [smallstep_ca_dir](defaults/main.yml#L82) | str | `{{ smallstep_bin_dir }}/ca` |
| [smallstep_ca_dns](defaults/main.yml#L12) | str | `ca.internal.guru` |
| [smallstep_ca_name](defaults/main.yml#L11) | str | `Internal Root CA Certificate` |
| [smallstep_ca_password_file](defaults/main.yml#L87) | str | `{{ smallstep_ca_secrets_dir }}/password` |
| [smallstep_ca_port](defaults/main.yml#L13) | str | `4443` |
| [smallstep_ca_provisioner](defaults/main.yml#L14) | str | `admin` |
| [smallstep_ca_scripts_url](defaults/main.yml#L16) | str | `https://{{ smallstep_ca_dns }}/scripts` |
| [smallstep_ca_secrets_dir](defaults/main.yml#L85) | str | `{{ smallstep_ca_dir }}/secrets` |
| [smallstep_ca_server_url](defaults/main.yml#L15) | str | `https://{{ smallstep_ca_dns }}:{{ smallstep_ca_port }}` |
| [smallstep_ca_url](defaults/main.yml#L104) | str | `{{ smallstep_base_url }}/certificates/releases/download/v{{ smallstep_ca_version }}/{{ smallstep_ca_archive }}` |
| [smallstep_ca_validity](defaults/main.yml#L18) | str | `87660h` |
| [smallstep_ca_version](defaults/main.yml#L102) | str | `0.28.3` |
| [smallstep_certificates](defaults/main.yml#L37) | list |  |
| [smallstep_cleanup_old_backups](defaults/main.yml#L32) | bool | `True` |
| [smallstep_cli_archive](defaults/main.yml#L108) | str | `step_linux_{{ smallstep_cli_version }}_amd64.tar.gz` |
| [smallstep_cli_url](defaults/main.yml#L109) | str | `{{ smallstep_base_url }}/cli/releases/download/v{{ smallstep_cli_version }}/{{ smallstep_cli_archive }}` |
| [smallstep_cli_version](defaults/main.yml#L107) | str | `0.28.6` |
| [smallstep_default_tls_cert_duration](defaults/main.yml#L35) | str | `4380h` |
| [smallstep_enable_auto_renewal](defaults/main.yml#L30) | bool |  |
| [smallstep_intermediate_ca_validity](defaults/main.yml#L19) | str | `87660h` |
| [smallstep_issued_dir](defaults/main.yml#L89) | str | `{{ smallstep_ca_dir }}/issued` |
| [smallstep_link_path](defaults/main.yml#L80) | str | `/usr/local/bin` |
| [smallstep_max_tls_cert_duration](defaults/main.yml#L34) | str | `87660h` |
| [smallstep_renewal_threshold](defaults/main.yml#L31) | int | `30` |
| [smallstep_restore_archive](defaults/main.yml#L100) | str |  |
| [smallstep_service_group](defaults/main.yml#L23) | str | `step` |
| [smallstep_service_user](defaults/main.yml#L22) | str | `step` |
| [smallstep_www_certs_dir](defaults/main.yml#L92) | str | `{{ smallstep_www_dir }}/certs` |
| [smallstep_www_dir](defaults/main.yml#L91) | str | `{{ smallstep_bin_dir }}/www` |
| [smallstep_www_scripts_dir](defaults/main.yml#L93) | str | `{{ smallstep_www_dir }}/scripts` |




## Task Overview


This role performs the following tasks:


### File: `tasks/renew_certs.yml`

| Task Name | Module | Has Conditions | Line |
|-----------|--------|----------------|------|
| [Check certificate expiration status](tasks/renew_certs.yml#L) | ansible.builtin.command | No | N/A |
| [Parse certificate expiration dates](tasks/renew_certs.yml#L) | ansible.builtin.set_fact | Yes | N/A |
| [Display certificates needing renewal](tasks/renew_certs.yml#L) | ansible.builtin.debug | No | N/A |
| [Create backup directories for old certificates](tasks/renew_certs.yml#L) | ansible.builtin.file | Yes | N/A |
| [Create backup directories for old private keys](tasks/renew_certs.yml#L) | ansible.builtin.file | Yes | N/A |
| [Copy existing certificates to the backup directory](tasks/renew_certs.yml#L) | ansible.builtin.copy | Yes | N/A |
| [Copy existing private keys to the backup directory](tasks/renew_certs.yml#L) | ansible.builtin.copy | Yes | N/A |
| [Renew certificates using the step ca renew command](tasks/renew_certs.yml#L) | ansible.builtin.command | Yes | N/A |
| [Reissue certificates when renewal fails](tasks/renew_certs.yml#L) | ansible.builtin.command | Yes | N/A |
| [Recreate fullchain certificates (certificate, intermediate and root only)](tasks/renew_certs.yml#L) | ansible.builtin.shell | Yes | N/A |
| [Verify the renewed certificates](tasks/renew_certs.yml#L) | ansible.builtin.command | Yes | N/A |
| [Get renewed certificate information](tasks/renew_certs.yml#L) | ansible.builtin.command | Yes | N/A |
| [Update the certificate info file for renewed certificates](tasks/renew_certs.yml#L) | ansible.builtin.template | Yes | N/A |
| [Restart the services that consume renewed certificates](tasks/renew_certs.yml#L) | ansible.builtin.systemd | Yes | N/A |
| [Clean up old certificate backups (keep the last 5)](tasks/renew_certs.yml#L) | ansible.builtin.shell | Yes | N/A |
| [Clean up old private key backups (keep the last 5)](tasks/renew_certs.yml#L) | ansible.builtin.shell | Yes | N/A |




### File: `tasks/restore.yml`

| Task Name | Module | Has Conditions | Line |
|-----------|--------|----------------|------|
| [Assert that a backup archive is provided for the restore](tasks/restore.yml#L) | ansible.builtin.assert | No | N/A |
| [Stop the CA while restoring](tasks/restore.yml#L) | ansible.builtin.systemd | No | N/A |
| [Restore the CA database, secrets and configuration](tasks/restore.yml#L) | ansible.builtin.unarchive | No | N/A |
| [Restore the configuration ownership](tasks/restore.yml#L) | ansible.builtin.file | No | N/A |
| [Start the CA after restoring](tasks/restore.yml#L) | ansible.builtin.systemd | No | N/A |




### File: `tasks/issue_certs.yml`

| Task Name | Module | Has Conditions | Line |
|-----------|--------|----------------|------|
| [Create the certificate distribution directories](tasks/issue_certs.yml#L) | ansible.builtin.file | No | N/A |
| [Create the private key directories outside the distribution tree](tasks/issue_certs.yml#L) | ansible.builtin.file | No | N/A |
| [Get the CA fingerprint](tasks/issue_certs.yml#L) | ansible.builtin.command | No | N/A |
| [Set the CA fingerprint fact](tasks/issue_certs.yml#L) | ansible.builtin.set_fact | No | N/A |
| [Check if the client bootstrap already exists](tasks/issue_certs.yml#L) | ansible.builtin.stat | No | N/A |
| [Bootstrap the step client with the CA fingerprint](tasks/issue_certs.yml#L) | ansible.builtin.command | Yes | N/A |
| [Issue certificates using the step ca certificate command](tasks/issue_certs.yml#L) | ansible.builtin.command | No | N/A |
| [Restrict issued private keys](tasks/issue_certs.yml#L) | ansible.builtin.file | No | N/A |
| [Create fullchain certificates (certificate, intermediate and root only)](tasks/issue_certs.yml#L) | ansible.builtin.shell | No | N/A |
| [Publish the certificates and chains as readable files](tasks/issue_certs.yml#L) | ansible.builtin.file | No | N/A |
| [Verify the issued certificates](tasks/issue_certs.yml#L) | ansible.builtin.command | No | N/A |
| [Get certificate information](tasks/issue_certs.yml#L) | ansible.builtin.command | No | N/A |
| [Create the certificate info file](tasks/issue_certs.yml#L) | ansible.builtin.template | No | N/A |




### File: `tasks/generate_scripts.yml`

| Task Name | Module | Has Conditions | Line |
|-----------|--------|----------------|------|
| [Generate install-linux.sh script](tasks/generate_scripts.yml#L) | ansible.builtin.template | No | N/A |
| [Generate install-linux.sh script](tasks/generate_scripts.yml#L) | ansible.builtin.template | No | N/A |
| [Generate install-windows.ps1](tasks/generate_scripts.yml#L) | ansible.builtin.template | No | N/A |
| [Generate README.md](tasks/generate_scripts.yml#L) | ansible.builtin.template | No | N/A |




### File: `tasks/backup.yml`

| Task Name | Module | Has Conditions | Line |
|-----------|--------|----------------|------|
| [Create the backup directory](tasks/backup.yml#L) | ansible.builtin.file | No | N/A |
| [Set the backup archive path](tasks/backup.yml#L) | ansible.builtin.set_fact | No | N/A |
| [Check whether today's backup already exists](tasks/backup.yml#L) | ansible.builtin.stat | No | N/A |
| [Archive the database, secrets and configuration](tasks/backup.yml#L) | community.general.archive | Yes | N/A |
| [Find backups older than the retention period](tasks/backup.yml#L) | ansible.builtin.find | No | N/A |
| [Remove expired backups](tasks/backup.yml#L) | ansible.builtin.file | No | N/A |




### File: `tasks/init.yml`

| Task Name | Module | Has Conditions | Line |
|-----------|--------|----------------|------|
| [Assert that the vault supplies the CA password](tasks/init.yml#L) | ansible.builtin.assert | No | N/A |
| [Remove the legacy world readable password file](tasks/init.yml#L) | ansible.builtin.file | No | N/A |
| [Write the CA password file for the service account](tasks/init.yml#L) | ansible.builtin.copy | No | N/A |
| [Generate root CA certificate and key](tasks/init.yml#L) | ansible.builtin.command | No | N/A |
| [Generate intermediate CA certificate and key](tasks/init.yml#L) | ansible.builtin.command | No | N/A |
| [Generate provisioner JWK key pair](tasks/init.yml#L) | ansible.builtin.command | No | N/A |
| [Restrict CA private keys to the service account](tasks/init.yml#L) | ansible.builtin.file | No | N/A |
| [Make the CA public certificates readable](tasks/init.yml#L) | ansible.builtin.file | No | N/A |
| [Read the provisioner public key](tasks/init.yml#L) | ansible.builtin.slurp | No | N/A |
| [Read the provisioner encrypted private key](tasks/init.yml#L) | ansible.builtin.slurp | No | N/A |
| [Get root certificate fingerprint](tasks/init.yml#L) | ansible.builtin.command | No | N/A |
| [Set facts for JSON construction](tasks/init.yml#L) | ansible.builtin.set_fact | No | N/A |
| [Generate ca.json configuration](tasks/init.yml#L) | ansible.builtin.template | No | N/A |
| [Generate defaults.json configuration](tasks/init.yml#L) | ansible.builtin.template | No | N/A |
| [Create systemd unit for smallstep](tasks/init.yml#L) | ansible.builtin.template | No | N/A |
| [Start and enable smallstep service](tasks/init.yml#L) | ansible.builtin.systemd | No | N/A |
| [Apply pending configuration restarts before the CA is used](tasks/init.yml#L) | ansible.builtin.meta | No | N/A |




### File: `tasks/install.yml`

| Task Name | Module | Has Conditions | Line |
|-----------|--------|----------------|------|
| [Create the smallstep service group](tasks/install.yml#L) | ansible.builtin.group | No | N/A |
| [Create the smallstep service account](tasks/install.yml#L) | ansible.builtin.user | No | N/A |
| [Create the smallstep binary directories](tasks/install.yml#L) | ansible.builtin.file | No | N/A |
| [Create the smallstep CA directories](tasks/install.yml#L) | ansible.builtin.file | No | N/A |
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
| [Restore a CA backup](tasks/main.yml#L) | ansible.builtin.include_tasks | Yes | N/A |
| [Generate client scripts](tasks/main.yml#L) | ansible.builtin.include_tasks | No | N/A |
| [Issue certificates](tasks/main.yml#L) | ansible.builtin.include_tasks | Yes | N/A |
| [Renew certificates](tasks/main.yml#L) | ansible.builtin.include_tasks | Yes | N/A |
| [Back up the CA database, secrets and configuration](tasks/main.yml#L) | ansible.builtin.include_tasks | Yes | N/A |






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

## License


license (GPL-2.0-or-later, MIT, etc)


## Author Information


**Author:** gkorkmaz




**GitHub:** [gkorkmaz](https://github.com/gkorkmaz)

---
*This documentation was automatically generated using [docsible](https://github.com/zbohm/docsible).*
<!-- DOCSIBLE END -->
