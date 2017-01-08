# ansible-role-blynk-server

A brief description of the role goes here.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `blynk_server_user` | user of the server | `{{ __blynk_server_user }}` |
| `blynk_server_group` | group of the server | `{{ __blynk_server_group }}` |
| `blynk_server_service` | service name | `{{ __blynk_server_service }}` |
| `blynk_server_bin` | path to `jar` file | `{{ __blynk_server_bin }}` |
| `blynk_server_home` | path to the directory of `jar` file and other files | `{{ blynk_server_bin | dirname }}` |
| `blynk_server_version` | | `0.21.1` |
| `blynk_server_version_checksum` | checksum of the `jar` file | `{"0.21.1"=>{"sha1"=>"dfe1be1d71723763dad8a75727612d2ed4e1bba3", "sha256"=>"f7835fa69e0e56b264c121e96c9d6d19eb0f6e694a5ac9168afd3029f19794c0"}}` |
| `blynk_server_dist_url` | URL of the `jar` file | `https://github.com/blynkkk/blynk-server/releases/download/v{{ blynk_server_version }}/server-{{ blynk_server_version }}.jar` |
| `blynk_server_tls_cert` | content of TLS cert | `""` |
| `blynk_server_tls_key` | content of encrypted TLS key | `""` |
| `blynk_server_tls_pass` | password to decrypt the encrypted TLS key | `""` |
| `blynk_server_config_dir` | path to the directory of config files | `{{ __blynk_server_config_dir }}` |
| `blynk_server_config_default` | dict of default configurations | see below |
| `blynk_server_config` | dict of configurations that overrides `blynk_server_config_default` | `{}` |
| `blynk_server_config_path` | path to `server.properties` | `{{ blynk_server_config_dir }}/server.properties` |
| `blynk_server_mail_properties` | dict of content of `mail.properties` | `{}` |
| `blynk_server_mail_properties_path` | path to `mail.properties` | `{{ blynk_server_home }}/mail.properties` |
| `blynk_server_sms_properties` | dict of content of `sms.properties` | `{}` |
| `blynk_server_sms_properties_path` | path to `sms.properties` | `{{ blynk_server_home }}/sms.properties` |
| `blynk_server_jvm_options` | list of `JAVA_OPTS` | `[]` |
| `blynk_server_extra_packages` | NOT implemented | `[]` |
| `blynk_server_java_home` | NOT implemented | `{{ __blynk_server_java_home }}` |

## `blynk_server_config_default`

```yaml
blynk_server_config_default:
  server.ssl.cert: "{{ blynk_server_config_dir }}/cert.pem"
  server.ssl.key: "{{ blynk_server_config_dir }}/key.pem"
  server.ssl.key.pass: "{{ blynk_server_tls_pass }}"
  https.cert: "{{ blynk_server_config_dir }}/cert.pem"
  https.key: "{{ blynk_server_config_dir }}/key.pem"
  https.key.pass: "{{ blynk_server_tls_pass }}"
  app.ssl.port: 8443
  hardware.default.port: 8442
  hardware.ssl.port: 8441
  https.port: 9443
  administration.https.port: 7443
  http.port: 8080
  ssl.websocket.port: 8081
  tcp.websocket.port: 8082
  data.folder: "{{ __blynk_server_data_dir }}"
  logs.folder: "{{ __blynk_server_log_dir }}"
  log.level: info
  enable.raw.data.store: "true"
  allowed.administrator.ips: 127.0.0.1/8
```

## Debian

| Variable | Default |
|----------|---------|
| `__blynk_server_user` | `www-data` |
| `__blynk_server_group` | `www-data` |
| `__blynk_server_service` | `blynk` |
| `__blynk_server_bin` | `/usr/local/blynk/blynk.jar` |
| `__blynk_server_config_dir` | `/etc/blynk` |
| `__blynk_server_data_dir` | `/var/lib/blynk` |
| `__blynk_server_log_dir` | `/var/log/blynk` |
| `__blynk_server_java_home` | `/usr/local/openjdk8` |

## FreeBSD

| Variable | Default |
|----------|---------|
| `__blynk_server_user` | `www` |
| `__blynk_server_group` | `www` |
| `__blynk_server_service` | `blynk` |
| `__blynk_server_bin` | `/usr/local/blynk/blynk.jar` |
| `__blynk_server_config_dir` | `/usr/local/etc/blynk` |
| `__blynk_server_data_dir` | `/var/db/blynk` |
| `__blynk_server_log_dir` | `/var/log/blynk` |
| `__blynk_server_java_home` | `/usr/local/openjdk8` |

## OpenBSD

| Variable | Default |
|----------|---------|
| `__blynk_server_user` | `www` |
| `__blynk_server_group` | `www` |
| `__blynk_server_service` | `blynk` |
| `__blynk_server_bin` | `/usr/local/blynk/blynk.jar` |
| `__blynk_server_config_dir` | `/etc/blynk` |
| `__blynk_server_data_dir` | `/var/db/blynk` |
| `__blynk_server_log_dir` | `/var/log/blynk` |
| `__blynk_server_java_home` | `/usr/local/openjdk8` |

## RedHat

| Variable | Default |
|----------|---------|
| `__blynk_server_user` | `www-data` |
| `__blynk_server_group` | `www-data` |
| `__blynk_server_service` | `blynk` |
| `__blynk_server_bin` | `/usr/local/blynk/blynk.jar` |
| `__blynk_server_config_dir` | `/etc/blynk` |
| `__blynk_server_data_dir` | `/var/lib/blynk` |
| `__blynk_server_log_dir` | `/var/log/blynk` |
| `__blynk_server_java_home` | `/usr/local/openjdk8` |

# Dependencies

* reallyenglish.java

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-blynk-server
  vars:
    blynk_server_config:
      allowed.administrator.ips: 0.0.0.0/0
    blynk_server_tls_cert: |
      -----BEGIN CERTIFICATE-----
      MIIDhTCCAm2gAwIBAgIJANoweLcD5utMMA0GCSqGSIb3DQEBCwUAMFkxCzAJBgNV
      BAYTAkFVMRMwEQYDVQQIDApTb21lLVN0YXRlMSEwHwYDVQQKDBhJbnRlcm5ldCBX
      aWRnaXRzIFB0eSBMdGQxEjAQBgNVBAMMCWxvY2FsaG9zdDAeFw0xNjEyMzEwODMy
      MjVaFw0yMTEyMzAwODMyMjVaMFkxCzAJBgNVBAYTAkFVMRMwEQYDVQQIDApTb21l
      LVN0YXRlMSEwHwYDVQQKDBhJbnRlcm5ldCBXaWRnaXRzIFB0eSBMdGQxEjAQBgNV
      BAMMCWxvY2FsaG9zdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALnv
      ZF99Uh+oSWC8XfUlJ2LI/5gZ5XekqNfuGncC3mT1hx3UVFa8BLQYpNDVBxPjQlc9
      SOOOnCKq3F/ZyAeuBS4ZqJQDfllCzjPKUnFjWkFMTsu88ZoCLx7cI3x/G9dOr9a+
      NO1+z8pghT4ZqhWPoGkfPC9BveDypmEXQWmj67qvj9ri9ClNCxy2o4GTxV2cqscl
      vmfQ/CcTVoNCw94AL+2H5Micp9jJNgcOjE1qsjuVAAh1AyHFDhDlG31VgxtZ/tnL
      HSw1tGxaQjQ+k447lcyD/iOG7yjbALdN/rh6DEL/p8FABTtLgIYTEoM8XZf/z3ji
      ltwlyUpPiWE7WB+YAmECAwEAAaNQME4wHQYDVR0OBBYEFGYPIoI0JkWy1qEkcGz3
      RShKaDQTMB8GA1UdIwQYMBaAFGYPIoI0JkWy1qEkcGz3RShKaDQTMAwGA1UdEwQF
      MAMBAf8wDQYJKoZIhvcNAQELBQADggEBAFTxSCzQitQayULXmTddVEnlmy7HUnFd
      H+lq8YnyY40z9cCZaKDc6Kk50oC9WCPHxO6wLzm2e9rwc6vHvPUNtwKTymnW8pyk
      bG9ZidiPiZ8oczgPct5OxG6sit7yDchYx2Gj6ekFS/4stJo3wCnnKqt36Zv1t3R3
      S1eLe83B9Z03xvphYKP6YXNdCCPFJb5DSQoyP6aMst7U9g0TjaV8AXAnehxQ3SNO
      xuSdStMQ+nvHGJEzk+edrHOi4PA7a7mn4mEZCC3LCkDO7rqapJqw1UW+pdrieTAu
      thlOKExxVZI1yWcGyIni1wckO9ScTiv+7avUtpuIAL0pdmC2XBc2l+w=
      -----END CERTIFICATE-----
    blynk_server_tls_key: |
      -----BEGIN ENCRYPTED PRIVATE KEY-----
      MIIE6TAbBgkqhkiG9w0BBQMwDgQIgYj8Xfnq3wcCAggABIIEyK9uYOJlKKqJgtCD
      xoit6fn/YhdBTgxV/Lr5K52FWcsR5PSFy0nzbDcxlXmJ51WEbly1t1OHA4ulxkQr
      Nnkgir9eiDfi4Z+xHfDCVFCXtlEp73V1EUfGo5fW7hO+ce4WfgQ4/PT814+boOc6
      /T7myoo0XHGQibBg7nbig8bGaA6MOqg35xDkBcu96CvBnP/fkgSWm7nZXA2j8KWa
      RoJDOLmfBkPT1GOZowuHxcXgzoFSxfMtmD+o5Vm6QudD4rQ8U/JVlBeW77DViyN0
      4rvX33plHS93tuJYaRE872Y7d/NBdgfqDhF/7MX98ZksGfQGk+IThKuAwEa9bMLF
      4WgSqQ7QxfqjcXTsvF10XLqAo5nIR2/JCcXcfqF5INJdtskaf7taDWoOdC3USqAK
      XQs4b3Ki2nqxVrwTIdsjSwsPePaQJJM8iJllujbfsPikHH3fYGJrOG8j4ykkuZdh
      J3PgtkSw9F1ZJSUUynugN6yVUbkqKQmuWRNITl9pDgbUe4NbgsoZ/OaxHQOocwmO
      H5kZ92h4aR25r7PBITFlICNKvZ8BjcFGcHQTTK9Dnxxdliht1YJs700s8ShoslPD
      y1HuHf7o8m2XRffiseraMDT38eL4IhEUoCycJGaZv4SNO1DPM4XVGGTW0NRh4GXs
      ncw1KvO9vLUkX+p2YmEm5KgBqO24Hs7d+SwkzOLioSqniJeHEdw/3pYhZ9Y1SVwU
      J2289O+hDuWh6FvqhCjpxcikN8rRQ4aKMb8LwD/k9Lchbp2jaciuPmKpkIr+2wG8
      NNhVfX7FcWuc/fB1WN0m0IXEH4P1DrqcPIs4Ilx4DJl0e7RmQrafMkqWn6TKj5hL
      D9oNYECYj7bGs4/AxJns2Gbd26TzHAyr9u78qmJvxvvHwAjkSYJ/snopuzZkDJip
      K1oWzrz/h1y0qyTeilAUcjfEDxhol4E4JgBUNIS1GPz+Hf/WdtOS01FZWJ4vNuWB
      RuAwZYZdkUA/jO6HfVsyyZBAt49/2DxJcT8K8OxFIYTqhJB/9dOfcOeZLIWjUfA8
      uGgmh0loeMlrsOUN3qv0UHD+Pm5xDGBtPNGMF1e/ES+bM/YCVmDY/v1I0lezUq8z
      mYg5YBHnkPt9ShUawhtvxO81luehusdtt6v4qIwIFJ9pwC5kXc+rJ8TQp4ujlEWc
      6LRPZsKmxfAmJG9yirHN0wT54kHwnW5R4gso20gn1beQ1up7Tn5Qlfh+FGTo8vTo
      0hPxCwTxm4w9+VzqNiJQjjIQcDY4e6sH7breG6WJ9nUFnp4BZzqrMsUF10N2lw4o
      LrzqwlOhP3aGZsWv1GGZBk8m2qTgZ9sRCH4C22Yhgdv9ngA9cQajj8RayBRP+kKq
      SumSgZfYw0SZ948Svi0eOSvs0A+G+9L5a0FyB/8kxQochJDQZuinJ4weYG7nQciV
      e8bBTdGdzeKOkbXynJuMwcX53TOMbgmHparLzNsnLPig5mIijzgeZqjrPWN9WNbC
      2CLBVuA3eQKjDqt+Y3girNA5J0K2xNIqr8Eg/NBgICy0JMS6ODKpD4VvuLJvP/vS
      1C4/0R0BR90lx91G+nTZgmUP0IGOvPo+n6jRXYyu5WHEsxiAbyqgjB0MrV69uWKW
      Pvz3QLyHb83WUuQxgA==
      -----END ENCRYPTED PRIVATE KEY-----
    blynk_server_tls_pass: password
    blynk_server_mail_properties:
      mail.smtp.auth: "true"
      mail.smtp.starttls.enable: "true"
      mail.smtp.host: smtp.gmail.com
      mail.smtp.port: 587
      mail.smtp.username: username
      mail.smtp.password: password
    blynk_server_sms_properties:
      nexmo.api.key: foobarbuz
      nexmo.api.secret: secret
    blynk_server_jvm_options:
      - -Djava.awt.headless=true
    apt_repo_to_add: "{% if ansible_distribution == 'Ubuntu' and ansible_distribution_version | version_compare('16.04', '<') %}[ 'ppa:webupd8team/java' ]{% else %}[]{% endif %}"
```

# License

```
Copyright (c) 2016 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [qansible](https://github.com/trombik/qansible)
