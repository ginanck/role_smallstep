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

| Variable | Default Value | Description |
|----------|---------------|-------------|
| `smallstep_ca_name` | `Internal Root CA Certificate` | None |
| `smallstep_ca_dns` | `ca.internal.guru` | None |
| `smallstep_ca_port` | `4443` | None |
| `smallstep_ca_provisioner` | `admin` | None |
| `smallstep_ca_server_url` | `https://{{ smallstep_ca_dns }}:{{ smallstep_ca_port }}` | None |
| `smallstep_ca_scripts_url` | `http://{{ smallstep_ca_dns }}/scripts` | None |
| `smallstep_ca_validity` | `87660h` | None |
| `smallstep_intermediate_ca_validity` | `87660h` | None |
| `smallstep_enable_auto_renewal` | `False` | None |
| `smallstep_renewal_threshold` | `30` | None |
| `smallstep_cleanup_old_backups` | `True` | None |
| `smallstep_max_tls_cert_duration` | `87660h` | None |
| `smallstep_default_tls_cert_duration` | `4380h` | None |
| `smallstep_certificates` | `[]` | None |
| `smallstep_base_url` | `https://github.com/smallstep` | None |
| `smallstep_bin_dir` | `/opt/smallstep` | None |
| `smallstep_link_path` | `/usr/local/bin` | None |
| `smallstep_www_dir` | `{{ smallstep_bin_dir }}/www` | None |
| `smallstep_www_certs_dir` | `{{ smallstep_www_dir }}/certs` | None |
| `smallstep_www_scripts_dir` | `{{ smallstep_www_dir }}/scripts` | None |
| `smallstep_log_dir` | `/var/log/smallstep` | None |
| `smallstep_ca_version` | `0.28.3` | None |
| `smallstep_ca_archive` | `step-ca_linux_{{ smallstep_ca_version }}_amd64.tar.gz` | None |
| `smallstep_ca_url` | `{{ smallstep_base_url }}/certificates/releases/download/v{{ smallstep_ca_version }}/{{ smallstep_ca_archive }}` | None |
| `smallstep_cli_version` | `0.28.6` | None |
| `smallstep_cli_archive` | `step_linux_{{ smallstep_cli_version }}_amd64.tar.gz` | None |
| `smallstep_cli_url` | `{{ smallstep_base_url }}/cli/releases/download/v{{ smallstep_cli_version }}/{{ smallstep_cli_archive }}` | None |




## Task Overview


This role performs the following tasks:


### `renew_certs.yml`


- **Check certificate expiration status**
- **Parse certificate expiration dates**
- **Display certificates needing renewal**
- **Create backup directory for old certificates**
- **Move existing certificates to backup directory**
- **Move existing private keys to backup directory**
- **Move existing fullchain certificates to backup directory**
- **Get CA root certificate fingerprint**
- **Set CA fingerprint fact**
- **Renew certificates using step ca renew command**
- **Generate new certificates if renewal fails (fallback)**
- **Recreate fullchain certificates with intermediate for renewed certs**
- **Verify renewed certificates**
- **Get renewed certificate information**
- **Update certificate info file for renewed certificates**
- **Log renewal completion with backup location**
- **Trigger service restarts for renewed certificates**
- **Clean up old certificate backup directories (keep last 5)**


### `issue_certs.yml`


- **Create certificate directories**
- **Get CA fingerprint**
- **Set CA fingerprint fact**
- **Check if bootstrap already exists**
- **Bootstrap step client with CA fingerprint**
- **Issue certificates using step ca certificate command**
- **Create fullchain certificates (with intermediate)**
- **Verify issued certificates**
- **Get certificate information**
- **Create certificate info file**


### `generate_scripts.yml`


- **Generate install-linux.sh script**
- **Generate install-linux.sh script**
- **Generate install-windows.ps1**
- **Generate README.md**


### `init.yml`


- **Update password file for ca-server**
- **CA Server Start Script**
- **Create CA directories**
- **Generate root CA certificate and key**
- **Generate intermediate CA certificate and key**
- **Generate provisioner JWK key pair**
- **Get root certificate fingerprint**
- **Read provisioner public key**
- **Read provisioner encrypted private key**
- **Set facts for JSON construction**
- **Generate ca.json configuration**
- **Generate defaults.json configuration**
- **Create systemd file for smallstep**
- **Start and enable smallstep service**


### `install.yml`


- **Create smallstep ca-server dir**
- **Download step-ca binary**
- **Unarchive step-ca Server**
- **Unarchive step-cli binary**
- **Copy binary files**
- **Set up alternatives for smallstep**


### `main.yml`


- **Install smallstep ca-server**
- **Initialize smallstep ca-server**
- **Generate certificates**
- **Issue certificates**
- **Renew certificates**




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
