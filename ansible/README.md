# Requirements

 - ansible
 - curl
 - git

sudo dnf install -y ansible curl git psutil


# Execute the entire playbook with

```
 ansible-playbook ansible-desktop.yml --ask-become-pass
```

# Execute only selected tags

```
 ansible-playbook ansible-desktop.yml --ask-become-pass --tags "java"
```